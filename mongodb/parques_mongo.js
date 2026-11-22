use agencia

db.atracciones.insertMany([
  {
    codigo: 1122,
    nombre: "Fuegos artificiales",
    codigo_p: 1,
    tipo: "show",
    etiquetas: ["familiar", "aire libre"],
    caracteristicas: { duracion_min: 90, horarios: ["11:00", "15:00"] }
  },
  {
    codigo: 2233,
    nombre: "Montaña rusa",
    codigo_p: 1,
    tipo: "juego mecanico",
    etiquetas: ["riesgo", "aire libre"],
    caracteristicas: { altura_minima_cm: 150, nivel_intensidad: "alto" }
  },
  {
    codigo: 3344,
    nombre: "Carrusel",
    codigo_p: 2,
    tipo: "juego mecanico",
    etiquetas: ["familiar", "niños"],
    caracteristicas: { altura_minima_cm: 100, nivel_intensidad: "bajo" }
  },
  {
    codigo: 4435,
    nombre: "Rico Rico",
    codigo_p: 2,
    tipo: "restaurante",
    etiquetas: ["interior", "gourmet"],
    caracteristicas: {
      tipo_cocina: "gourmet",
      rango_precios: "50-200 USD",
      opciones: ["sin TACC", "veggie"]
    }
  }
])

// CONSULTA 5 
db.atracciones.find({ codigo: 1122 })

/*
Resultado:

{
  _id: ObjectId('6b025162aa4dac1b3ee45d6a'),
  codigo: 1122,
  nombre: 'Fuegos artificiales',
  codigo_p: 1,
  tipo: 'show',
  etiquetas: [
    'familiar',
    'aire libre'
  ],
  caracteristicas: {
    duracion_min: 90,
    horarios: [
      '11:00',
      '15:00'
    ]
  }
}
*/

// CONSULTA 6
db.atracciones.find({
  tipo: "juego mecanico",
  codigo_p: 2,
  "caracteristicas.altura_minima_cm": { $lte: 120 }
})

/*
Resultado: 

{
  _id: ObjectId('6b025162aa4dac1b3ee45d6c'),
  codigo: 3344,
  nombre: 'Carrusel',
  codigo_p: 2,
  tipo: 'juego mecanico',
  etiquetas: [
    'familiar',
    'niños'
  ],
  caracteristicas: {
    altura_minima_cm: 100,
    nivel_intensidad: 'bajo'
  }
}
*/
