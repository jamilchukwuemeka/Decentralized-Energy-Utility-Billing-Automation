# Decentralized Energy Utility Billing Automation

A comprehensive blockchain-based solution for automating utility billing processes using Clarity smart contracts on the Stacks blockchain.

## Overview

This system provides a decentralized approach to utility billing that ensures transparency, reduces fraud, and automates the entire billing cycle from meter readings to payment processing.

## Features

- **Utility Company Verification**: Secure registration and verification of utility companies
- **Automated Meter Reading**: Smart contract-based meter reading collection and verification
- **Usage Calculation**: Automated calculation of utility usage and costs
- **Bill Generation**: Automated generation of utility bills based on usage
- **Payment Processing**: Secure payment processing and balance tracking

## Smart Contracts

### 1. Utility Verification Contract (`utility-verification.clar`)
- Manages utility company registration
- Handles company verification process
- Stores company information and admin mappings

### 2. Meter Reading Contract (`meter-reading.clar`)
- Registers customer meters
- Collects and stores meter readings
- Provides reading verification functionality

### 3. Usage Calculation Contract (`usage-calculation.clar`)
- Calculates utility usage based on meter readings
- Manages utility rates for different companies
- Computes total costs for billing periods

### 4. Billing Generation Contract (`billing-generation.clar`)
- Generates utility bills automatically
- Tracks bill status and due dates
- Provides overdue bill checking

### 5. Payment Processing Contract (`payment-processing.clar`)
- Processes utility bill payments
- Maintains customer balance tracking
- Supports multiple payment methods

## Getting Started

### Prerequisites
- Clarinet CLI tool
- Stacks wallet
- Node.js (for testing)

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd energy-billing-system
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

1. Deploy contracts using Clarinet:
   \`\`\`bash
   clarinet deploy
   \`\`\`

2. Verify deployment on Stacks Explorer

## Usage

### For Utility Companies

1. **Register Company**:
    - Call `register-company` with company details
    - Wait for verification from contract owner

2. **Set Utility Rates**:
    - Use `set-utility-rate` to establish pricing

3. **Verify Readings**:
    - Verify meter readings using `verify-reading`

### For Customers

1. **Register Meter**:
    - Register your meter with a verified utility company

2. **View Bills**:
    - Check generated bills using `get-bill`

3. **Make Payments**:
    - Process payments using `process-payment`

## API Reference

### Utility Verification
- `register-company(name, address, license-number)` - Register new utility company
- `verify-company(company-id)` - Verify utility company (admin only)
- `get-company(company-id)` - Get company information
- `is-company-verified(company-id)` - Check verification status

### Meter Reading
- `register-meter(customer, meter-id, company-id)` - Register customer meter
- `submit-reading(meter-id, customer-address, company-id, reading-value, reading-type)` - Submit meter reading
- `verify-reading(meter-id, reading-id)` - Verify meter reading
- `get-reading(meter-id, reading-id)` - Get reading data

### Usage Calculation
- `set-utility-rate(company-id, rate-type, rate-per-unit)` - Set utility rates
- `calculate-usage(customer, period, meter-id, company-id, start-reading, end-reading, rate-type)` - Calculate usage
- `get-usage-calculation(customer, period)` - Get usage calculation
- `get-utility-rate(company-id, rate-type)` - Get current rates

### Billing Generation
- `generate-bill(customer, company-id, billing-period, usage-amount, total-amount, days-until-due)` - Generate bill
- `update-bill-status(customer, bill-id, new-status)` - Update bill status
- `get-bill(customer, bill-id)` - Get bill information
- `is-bill-overdue(customer, bill-id)` - Check if bill is overdue

### Payment Processing
- `process-payment(customer, company-id, bill-id, amount, payment-method)` - Process payment
- `add-charge(customer, company-id, amount)` - Add charges to balance
- `get-payment(payment-id)` - Get payment information
- `get-customer-balance(customer, company-id)` - Get customer balance

## Security Considerations

- All contracts include proper access controls
- Company verification prevents unauthorized utility companies
- Reading verification ensures data integrity
- Payment processing includes balance validation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the GitHub repository.
\`\`\`

Now let's create the PR details file:

