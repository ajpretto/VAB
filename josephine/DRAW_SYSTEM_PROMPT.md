# Claude Code Prompt: Draw Package Generator System Design

## Your Mission

You are designing a SaaS product called **"Draw Package Generator"** for General Contractors. Before designing anything, you must deeply understand how construction draws actually work by analyzing real documents from a live project.

---

## Phase 1: Document Analysis

You have access to the following documents from the **Josephine Apartments** project (Nicholas & Associates as GC, Sinatra Development as developer):

### 1. Conversation with Nicholas PM
**Location:** [User will provide - paste in chat or attach file]

**Extract from this conversation:**
- Pain points in their current draw process
- Time spent on draw preparation
- Common errors or rejections they experience
- How they currently track subcontractor submissions
- Their relationship/communication patterns with subs
- Any mentions of software they currently use
- Frustrations with the process
- What would make their life easier

### 2. Construction Budget (Excel)
**Location:** `/home/clawdbot/clawd/josephine/` or provided by user

**Analyze this document for:**
- Structure of the schedule of values (CSI divisions)
- How line items are organized and numbered
- Cost breakdown by trade/division
- How GMP (Guaranteed Maximum Price) is tracked
- Contingency, insurance, bond, and fee structures
- How subcontractor bids are entered and selected
- The relationship between divisions and subcontractors

### 3. Construction Schedule (PDF/MPP)
**Location:** `/home/clawdbot/clawd/josephine/Schedules/`

**Analyze this document for:**
- Project timeline and phases
- How work is sequenced
- Which trades work when
- Dependencies between trades
- How schedule relates to draw timing (monthly draws vs. work phases)

### 4. Fee Schedule (PDF)
**Location:** `/home/clawdbot/clawd/josephine/` or provided by user

**Analyze this document for:**
- Monthly draw percentages
- Retainage structure (10% hold)
- How draws map to project phases
- Total contract value breakdown
- Payment timing expectations

---

## Phase 2: Synthesis

After analyzing all documents, create a **"Current State Map"** that answers:

1. **The Monthly Draw Cycle:**
   - What triggers a draw request?
   - Who needs to submit what?
   - What documents are required?
   - What's the approval flow?
   - Where do delays happen?

2. **The Data Flow:**
   - How does work completed → invoice → G702/G703?
   - How is schedule of values tracked against actual billing?
   - How are change orders handled?
   - How is retainage calculated and tracked?

3. **The Pain Points:**
   - Where is manual data entry happening?
   - Where are errors most likely?
   - What causes draw rejections?
   - What takes the most time?

4. **The Stakeholders:**
   - GC project manager (creates draws)
   - Subcontractors (submit invoices + waivers)
   - Developer/Owner (approves draws)
   - Lender (releases funds)
   - What does each party need?

---

## Phase 3: Product Design

Design the **Draw Package Generator** with these components:

### 3.1 Data Model
Define the core entities:
- Projects
- Subcontractors
- Schedule of Values (line items)
- Draw Requests
- Invoices
- Lien Waivers
- G702/G703 Forms

Include relationships and key fields for each.

### 3.2 Core Features

**A. Subcontractor Portal**
- Self-service invoice upload
- Lien waiver upload (conditional/unconditional templates)
- View their schedule of values line items
- See payment history
- Mobile-friendly

**B. Automated Tracking Dashboard**
- Visual status of all subs for current draw
- Auto-reminders (configurable: 7 days, 3 days, 1 day before deadline)
- Missing document alerts
- Submission history

**C. AI-Powered Invoice Processing**
- OCR extraction from uploaded invoices
- Auto-match to schedule of values line items
- Flag discrepancies (invoice amount vs. budget remaining)
- Learn from corrections

**D. G702/G703 Auto-Generation**
- Pull data from schedule of values
- Calculate: original contract, change orders, completed to date, retainage, etc.
- Pre-fill from subcontractor submissions
- One-click generation

**E. Pre-Submission Validation**
- Checklist: all invoices received?
- Checklist: all lien waivers received?
- Math validation (no line item over budget)
- Retainage calculation check
- Missing signature detection

**F. Draw Package Compilation**
- Combine all documents into single PDF
- Professional formatting
- Table of contents
- Ready for developer/lender submission

### 3.3 User Flows
Create step-by-step flows for:
1. GC sets up a new project (imports schedule of values)
2. GC invites subcontractors to portal
3. Sub submits invoice + waiver for monthly draw
4. GC reviews submissions and generates draw package
5. Handling a rejected draw (what needs to be fixed)

### 3.4 Technical Architecture
Recommend:
- Frontend framework
- Backend approach
- Database choice
- File storage (invoices, waivers, generated PDFs)
- AI/OCR service for invoice processing
- PDF generation approach

### 3.5 MVP Scope
What's the minimum viable product that delivers value?
- Must-have features for v1
- Nice-to-have features for v2
- Features that can wait

---

## Phase 4: Implementation Plan

Create a phased roadmap:

### Week 1-2: Foundation
- Data model and database
- Basic authentication
- Project setup flow

### Week 3-4: Subcontractor Portal
- Invite system
- Upload interface
- Document storage

### Week 5-6: Tracking & Reminders
- Dashboard
- Status tracking
- Email/SMS reminders

### Week 7-8: Form Generation
- G702/G703 templates
- Auto-population logic
- PDF generation

### Week 9-10: AI Integration
- Invoice OCR
- Auto-matching
- Validation rules

### Week 11-12: Polish & Launch
- Draw package compilation
- Testing with real data
- User feedback iteration

---

## Deliverables

After your analysis, provide:

1. **Executive Summary** (1 page)
   - The problem
   - The solution
   - Key differentiators

2. **Current State Analysis** (from document review)
   - Insights from each document
   - Pain points identified
   - Opportunities discovered

3. **Product Specification**
   - Data model diagrams
   - Feature specifications
   - User flow diagrams
   - UI wireframe descriptions

4. **Technical Plan**
   - Architecture decisions
   - Technology choices with rationale
   - Integration points

5. **Implementation Roadmap**
   - Phased timeline
   - MVP definition
   - Resource estimates

6. **Go-to-Market Thoughts**
   - Target customer profile
   - Pricing model ideas
   - Competitive positioning vs. Built, Procore, etc.

---

## Important Notes

- This is a REAL project with REAL documents. The insights should be specific, not generic.
- The Josephine Apartments project is $22.2M with 99 units. Use actual numbers from the documents.
- Nicholas & Associates is the GC. Understand their specific workflow.
- The goal is to build something they would actually pay for and use.

Start by reading and analyzing each document thoroughly. Show your work - quote specific sections, reference actual line items, cite real numbers. Then synthesize into the product design.
