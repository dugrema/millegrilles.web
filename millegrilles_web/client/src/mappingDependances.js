// import React from 'react'
//
// import TestApp2 from './containers/Test'
//
// class TestApp extends React.Component {
//   render() {
//     return <p>Test app protegee simple</p>
//   }
// }
//
// export const MAPPING_DEPENDANCES = [
//   {
//     nom: "testapp",
//     nomFormatte: "Application de test",
//     dom: TestApp,
//     securite: "3.protege"
//   },
//   {
//     nom: "testapp2",
//     nomFormatte: "Application de test #2",
//     // Exemple de code splitting
//     load: async _=>{return (await import('./containers/Test')).default},
//     securite: "3.protege"
//   }
// ]

export const MAPPING_DEPENDANCES = [
  {
    nom: "coupdoeil",
    nomFormatte: "Coup D'Oeil",
    load: async _=>{return (await import('./deps/coupdoeil')).default},
    securite: "3.protege"
  }
]
