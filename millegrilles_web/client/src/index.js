import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom'

import TestClass from './test'

import './index.css';
import * as serviceWorker from './serviceWorker';
import 'bootstrap/dist/css/bootstrap.min.css'
import 'font-awesome/css/font-awesome.min.css'

import Maitrecomptes from './containers/App'

class Test extends React.Component {

  state = {
    nanana: 1
  }

  render() {
    return <TestClass />
  }

}

ReactDOM.render(
  <React.StrictMode>
    <Router basename={'/millegrilles'}>
      <Route path='/' component={Maitrecomptes} />
    </Router>
  </React.StrictMode>,
  document.getElementById('root')
);


// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
