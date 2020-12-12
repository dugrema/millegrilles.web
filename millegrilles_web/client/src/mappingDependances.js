import manifest from './manifest.build.js'
import 'react-summernote/dist/react-summernote.css' // import styles pour Summernote

// Dependance pour Summernote (hack)
import $ from 'jquery'
window.jQuery = $

export function getManifest() {
  return manifest
}

export const MAPPING_DEPENDANCES = [
  {
    nom: "coupdoeil",
    nomFormatte: "Coup D'Oeil",
    load: async _=>{return (await import('./deps/millegrilles.coupdoeil-client/src/export.js')).default},
    securite: "3.protege"
  },
  {
    nom: "senseurspassifs",
    nomFormatte: "Senseurs Passifs",
    load: async _=>{return (await import('./deps/millegrilles.senseurspassifs-client/src/export.js')).default},
    securite: "3.protege"
  },
  {
    nom: "grosfichiers",
    nomFormatte: "GrosFichiers",
    load: async _=>{return (await import('./deps/millegrilles.grosfichiers-client/src/export.js')).default},
    securite: "3.protege"
  },
  {
    nom: "publication",
    nomFormatte: "Publication",
    load: async _=>{return (await import('./deps/millegrilles.publication-client/src/export.js')).default},
    securite: "3.protege"
  }
]
