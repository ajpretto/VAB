import { readFileSync, writeFileSync } from 'fs';
import libphonenumber from 'google-libphonenumber';

const phoneUtil = libphonenumber.PhoneNumberUtil.getInstance();
const PNF = libphonenumber.PhoneNumberFormat;
const PNT = libphonenumber.PhoneNumberType;

// Type names for display
const typeNames = {
  [PNT.FIXED_LINE]: 'Landline',
  [PNT.MOBILE]: 'Mobile',
  [PNT.FIXED_LINE_OR_MOBILE]: 'Landline/Mobile',
  [PNT.TOLL_FREE]: 'Toll-Free',
  [PNT.PREMIUM_RATE]: 'Premium Rate',
  [PNT.SHARED_COST]: 'Shared Cost',
  [PNT.VOIP]: 'VoIP',
  [PNT.PERSONAL_NUMBER]: 'Personal',
  [PNT.PAGER]: 'Pager',
  [PNT.UAN]: 'UAN',
  [PNT.VOICEMAIL]: 'Voicemail',
  [PNT.UNKNOWN]: 'Unknown'
};

// Parse phone number from various formats
function cleanPhone(raw) {
  // Remove common formatting: parentheses, dashes, spaces, dots
  return raw.replace(/[\s\-\.\(\)]/g, '');
}

// Validate a single phone number
function validatePhone(raw, country = 'US') {
  const cleaned = cleanPhone(raw);
  
  try {
    const parsed = phoneUtil.parse(cleaned, country);
    const isValid = phoneUtil.isValidNumber(parsed);
    const isPossible = phoneUtil.isPossibleNumber(parsed);
    const type = phoneUtil.getNumberType(parsed);
    
    return {
      original: raw,
      cleaned: cleaned,
      formatted: phoneUtil.format(parsed, PNF.NATIONAL),
      e164: phoneUtil.format(parsed, PNF.E164),
      isValid,
      isPossible,
      type: typeNames[type] || 'Unknown',
      typeCode: type,
      region: phoneUtil.getRegionCodeForNumber(parsed),
      error: null
    };
  } catch (err) {
    return {
      original: raw,
      cleaned: cleaned,
      formatted: null,
      e164: null,
      isValid: false,
      isPossible: false,
      type: 'Invalid',
      typeCode: -1,
      region: null,
      error: err.message
    };
  }
}

// Extract phone numbers from LEADS.md markdown table
function extractLeadsFromMarkdown(content) {
  const leads = [];
  const lines = content.split('\n');
  
  let currentCategory = '';
  
  for (const line of lines) {
    // Detect category headers
    if (line.startsWith('## ')) {
      currentCategory = line.replace('## ', '').trim();
      continue;
    }
    
    // Parse table rows (| # | Business | Phone | Website | Notes |)
    if (line.startsWith('|') && !line.includes('---') && !line.includes('Business') && !line.includes('Date')) {
      const cells = line.split('|').map(c => c.trim()).filter(c => c);
      
      // Skip header rows and empty rows
      if (cells.length >= 3 && cells[0].match(/^\d+$/)) {
        const num = cells[0];
        const business = cells[1];
        const phone = cells[2];
        const website = cells[3] || '';
        const notes = cells[4] || '';
        
        if (phone && phone.match(/\d/)) {
          leads.push({
            num: parseInt(num),
            business,
            phone,
            website,
            notes,
            category: currentCategory
          });
        }
      }
    }
  }
  
  return leads;
}

// Main execution
async function main() {
  const leadsPath = process.argv[2] || '../../synced/ai-voice-business/LEADS.md';
  console.log(`📱 Phone Validation Report`);
  console.log(`${'='.repeat(60)}\n`);
  
  // Read and parse leads
  const content = readFileSync(leadsPath, 'utf-8');
  const leads = extractLeadsFromMarkdown(content);
  
  console.log(`Found ${leads.length} leads with phone numbers\n`);
  
  // Validate each phone
  const results = leads.map(lead => ({
    ...lead,
    validation: validatePhone(lead.phone)
  }));
  
  // Stats
  const valid = results.filter(r => r.validation.isValid);
  const invalid = results.filter(r => !r.validation.isValid);
  const mobile = results.filter(r => r.validation.type === 'Mobile');
  const landline = results.filter(r => r.validation.type === 'Landline');
  const unknown = results.filter(r => r.validation.type === 'Unknown' && r.validation.isValid);
  
  console.log(`📊 Summary`);
  console.log(`${'─'.repeat(40)}`);
  console.log(`✅ Valid numbers:   ${valid.length} (${(valid.length/results.length*100).toFixed(1)}%)`);
  console.log(`❌ Invalid numbers: ${invalid.length}`);
  console.log(`📱 Mobile:          ${mobile.length}`);
  console.log(`📞 Landline:        ${landline.length}`);
  console.log(`❓ Unknown type:    ${unknown.length}`);
  console.log();
  
  // Show invalid numbers
  if (invalid.length > 0) {
    console.log(`\n❌ Invalid Numbers (${invalid.length})`);
    console.log(`${'─'.repeat(60)}`);
    for (const r of invalid) {
      console.log(`${r.num}. ${r.business}`);
      console.log(`   Phone: ${r.phone}`);
      console.log(`   Error: ${r.validation.error || 'Invalid format'}`);
      console.log();
    }
  }
  
  // Generate clean CSV for valid numbers
  const csvLines = [
    'Number,Business,Phone,Formatted,E164,Type,Category,Website,Notes'
  ];
  
  for (const r of valid) {
    const v = r.validation;
    csvLines.push([
      r.num,
      `"${r.business.replace(/"/g, '""')}"`,
      r.phone,
      v.formatted,
      v.e164,
      v.type,
      `"${r.category}"`,
      r.website,
      `"${(r.notes || '').replace(/"/g, '""')}"`
    ].join(','));
  }
  
  const csvPath = '../../synced/ai-voice-business/LEADS_VALIDATED.csv';
  writeFileSync(csvPath, csvLines.join('\n'));
  console.log(`\n✅ Wrote validated leads to: ${csvPath}`);
  
  // Generate clean markdown for valid numbers
  const categories = [...new Set(valid.map(r => r.category))];
  let md = `# Validated Lead List — Tampa Home Services\n\n`;
  md += `> **Generated:** ${new Date().toISOString().split('T')[0]}\n`;
  md += `> **Total Valid:** ${valid.length} leads\n\n`;
  
  for (const cat of categories) {
    const catLeads = valid.filter(r => r.category === cat);
    if (catLeads.length === 0) continue;
    
    md += `## ${cat}\n\n`;
    md += `| # | Business | Phone | Type | Website | Notes |\n`;
    md += `|---|----------|-------|------|---------|-------|\n`;
    
    for (const r of catLeads) {
      md += `| ${r.num} | ${r.business} | ${r.validation.formatted} | ${r.validation.type} | ${r.website} | ${r.notes} |\n`;
    }
    md += '\n';
  }
  
  const mdPath = '../../synced/ai-voice-business/LEADS_VALIDATED.md';
  writeFileSync(mdPath, md);
  console.log(`✅ Wrote validated markdown to: ${mdPath}`);
  
  // Return stats for programmatic use
  return {
    total: results.length,
    valid: valid.length,
    invalid: invalid.length,
    byType: {
      mobile: mobile.length,
      landline: landline.length,
      unknown: unknown.length
    },
    invalidList: invalid.map(r => ({
      num: r.num,
      business: r.business,
      phone: r.phone,
      error: r.validation.error
    }))
  };
}

main().catch(console.error);
