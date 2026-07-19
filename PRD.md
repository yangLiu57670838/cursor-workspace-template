# PRD: Banking Onboarding Demo

Demo product for bank staff to onboard **personal** and **business** accounts with identity and business verification.

## User

**Banker** — bank staff who starts and reviews onboarding applications. Customers do not use this UI.

## Goals

| Goal | Success criteria |
|------|------------------|
| Personal account onboarding | Banker can collect identity data and complete KYC |
| Business account onboarding | Banker can collect company + owner data and complete KYB |
| Review outcomes | Banker can see pass / fail / needs-review status |

## Flows

### Personal account + KYC

1. Banker starts a personal application
2. Collect identity details (name, DOB, ID document)
3. Run KYC checks
4. Show result: approved, rejected, or manual review

### Business account + KYB

1. Banker starts a business application
2. Collect company details (name, registration, address)
3. Collect beneficial owners / directors
4. Run KYB (and KYC on individuals as needed)
5. Show result: approved, rejected, or manual review

## Non-goals

- Real payment rails or live balances
- Customer self-serve portal
- Full AML case management beyond onboarding outcomes

## Scope note

This is a **demo**, not production banking software. Prefer clear happy-path flows over regulatory completeness.
