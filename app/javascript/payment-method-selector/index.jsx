import React from 'react'
import CreditCard from './forms/credit-card'
import Check from './forms/check'
import PurchaseOrder from './forms/purchase-order'

const PaymentForm = ({ paymentMethod }) => {
  if (paymentMethod == "Check") return <Check />;

  if (paymentMethod == "Credit card") return <CreditCard />;

  if (paymentMethod == "Purchase order") return <PurchaseOrder />;

  return (<div></div>);
};

class PaymentMethodSelector extends React.Component {
  constructor(props) {
    super(props);
    // make sure `this` is belong to the class
    this.onPaymentMethodSelected = this.onPaymentMethodSelected.bind(this);
    this.state = { selectedPayment: null };
  }

  onPaymentMethodSelected(event) {
    const paymentMethod = event.target.value;
    this.setState({ selectedPaymentMethod: paymentMethod });
  }

  render() {
    return (
      <div>
        <div className="field">
          <label htmlFor="order_payment_method">Payment Method</label>
          <select
            id="order_payment_method"
            name="order[payment_method]"
            onChange={this.onPaymentMethodSelected}
          >
            <option value="">Select a payment method</option>
            <option value="Check">Check</option>
            <option value="Credit card">Credit card</option>
            <option value="Purchase order">Purchase order</option>
          </select>
        </div>
        <PaymentForm paymentMethod={this.state.selectedPaymentMethod} />
      </div>
    );
  }
}

export default PaymentMethodSelector;
