# Draw Package / Pay App Software — Competitive Landscape

*Research: 2026-03-10 04:00 UTC*

---

## The Market

Construction payment applications (pay apps) are a massive pain point:
- **55 minutes** average time to manually process ONE payment application (GCPay stat)
- **4-6 days** → 4-6 hours with automation (GCPay customer testimonial)
- G702/G703 forms are industry standard but still mostly manual Excel/paper

---

## Key Players

### 1. GCPay (www.gcpay.com)
**Target:** General Contractors (primary competitor)  
**Users:** 48,000+  
**Pricing:** Project-based (not public, likely $X per project/month)

**Features:**
- Automated pay app submission & approval
- Lien waiver management (conditional/unconditional)
- Subcontractor portal
- Change order tracking
- ERP integrations (Sage, Viewpoint, Procore, CMiC)
- Digital signatures + Remote Online Notarization
- AIA G702/G703 form generation

**Positioning:** "Automate and simplify the entire payment application process"

**Customer Quote:**
> "A 4–6 day process to get a draw done has become a 4–6 hour process."
> — Sherry Campbell, Senior Project Accountant, Cityscape Residential

**Strengths:** 
- Purpose-built for GC pay app workflow
- Strong ERP integration ecosystem
- Mature product (48K users)

**Weaknesses:**
- Enterprise focus (likely expensive for small GCs)
- Requires ERP integration for full value
- Generic — not specialized for construction/development phase

---

### 2. Built Technologies (getbuilt.com)
**Target:** Lenders (banks, credit unions, debt funds)  
**Scale:** $200B+ in construction projects managed  
**Funding:** Major VC-backed

**Features:**
- Construction loan management
- Draw review and approval (LENDER side)
- AI Draw Agent (announced Nov 2025)
- Risk monitoring
- Compliance tracking

**Positioning:** "Financial workflow platform purpose-built to replace fragmented construction draw processes"

**Key Insight:** Built serves the OTHER side of the draw table — lenders reviewing draws, not GCs creating them. Different target market entirely.

**Strengths:**
- Massive scale, strong brand
- AI capabilities (Draw Agent)
- Deep lender relationships

**Weaknesses:**
- Wrong target customer (lenders not GCs)
- Doesn't solve GC's draw CREATION problem

---

### 3. Procore Pay (www.procore.com/pay)
**Target:** Procore users (enterprise GCs)  
**Pricing:** Add-on to Procore subscription

**Features:**
- Subcontractor invoice management
- Lien waiver collection
- Payment tracking
- G702/G703 support

**Positioning:** Part of Procore ecosystem

**Strengths:**
- Integrated with Procore project data
- Large install base

**Weaknesses:**
- Requires Procore subscription (expensive)
- Locked into ecosystem
- Small GCs unlikely to have Procore

---

### 4. Trimble Pay (formerly Flashtract)
**Target:** GCs and subcontractors  
**Acquisition:** Flashtract acquired by Trimble

**Features:**
- Payment automation
- Compliance management
- Lien waiver tracking
- Part of "Trimble Construction One"

**Positioning:** Payment and compliance within Trimble stack

**Strengths:**
- Strong compliance features
- Backed by Trimble resources

**Weaknesses:**
- Part of larger stack (not standalone)
- Trimble ecosystem dependency

---

### 5. Siteline (www.siteline.com)
**Target:** Subcontractors (NOT GCs)  
**Focus:** Help subs get paid faster

**Features:**
- Pay app creation for subs
- Lien waiver management
- Progress tracking
- Invoice submission

**Positioning:** "The only pay app tool built specifically for subcontractors"

**Key Insight:** Opposite target market — helps subs submit TO GCs, not GCs collect FROM subs.

**Strengths:**
- Focused product for subs
- Clear value prop

**Weaknesses:**
- Doesn't solve GC's problem
- Subs as customers have lower budgets

---

### 6. Oracle Textura
**Target:** Enterprise construction  
**Pricing:** Enterprise pricing

**Features:**
- Full payment management
- G702/G703 generation
- Lien waiver collection
- Compliance automation

**Positioning:** Part of Oracle Construction & Engineering suite

**Strengths:**
- Full-featured enterprise solution
- Oracle brand/support

**Weaknesses:**
- Enterprise pricing and complexity
- Overkill for smaller GCs

---

### 7. Levelset (www.levelset.com)
**Target:** Subs, suppliers, rental companies  
**Focus:** Lien rights and compliance (not pay apps)

**Features:**
- Preliminary notice management
- Lien waiver tracking
- Compliance workflows
- Document tracking

**Positioning:** "Payment rights and compliance platform"

**Key Insight:** Focused on lien rights/compliance, not the actual pay app creation workflow.

---

## Gap Analysis

| Need | GCPay | Built | Procore | Siteline |
|------|-------|-------|---------|----------|
| GC creates draw package | ✅ | ❌ | ✅ | ❌ |
| Sub portal for invoices | ✅ | ❌ | ✅ | N/A |
| G702/G703 generation | ✅ | ❌ | ✅ | ✅ |
| Lien waiver collection | ✅ | ❌ | ✅ | ✅ |
| AI invoice processing | ❌ | ✅ | ❌ | ❌ |
| Works standalone | ✅ | ✅ | ❌ | ✅ |
| Affordable for small GC | ❓ | ❌ | ❌ | N/A |

**The Gap:**
1. **No AI-powered invoice extraction** on the GC side (Built has it for lenders)
2. **Enterprise pricing** locks out smaller GCs and regional developers
3. **ERP integration required** for full value from GCPay
4. **No "design partner" model** — tools built in isolation from actual workflows

---

## Anthony's Opportunity

**Target:** Small-to-mid GCs like Nicholas & Associates  
**Angle:** Lightweight, focused draw package tool with AI invoice processing  
**Differentiator:** Built with actual GC workflow input (design partner model)

**MVP Features:**
1. Sub invoice upload portal
2. Auto-reminders before draw deadline
3. AI invoice OCR → match to schedule of values
4. G702/G703 auto-generation
5. Draw package PDF compilation

**What NOT to build first:**
- Full ERP integration
- Lender-side features
- Change order management
- Multi-project portfolio dashboards

**Pricing hypothesis:**
- GCPay: likely $200-500/project/month (enterprise)
- Anthony's tool: $99-199/project/month (accessible)

---

## Next Steps

1. **Validate pricing sensitivity** — ask Nicholas PM what they'd pay
2. **Map exact workflow** — who does what, when, in what tools
3. **Identify switching cost** — what would make them abandon Excel/email
4. **Talk to 2-3 other GCs** — validate pain is universal, not Nicholas-specific

---

*Research complete. Use this for positioning and feature prioritization.*
