import React from 'react'
import ReactDOM from 'react-dom'
import PaymentMethodSelector from 'payment-method-selector'

document.addEventListener('turbolinks:load', function() {
  var element = document.getElementById("payment-method-component");
  ReactDOM.render(<PaymentMethodSelector />, element);
});
