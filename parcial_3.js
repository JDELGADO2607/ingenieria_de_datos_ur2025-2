db.band.insertOne({
  name: 'Métricas Frías',
  country: 'Colombia',
  albums: [
    {
      title: 'Manzanas a la Vuelta',
      dateCreated: new Date("2016-09-16T05:00:00.000Z"),
      songs: [
        {
          songName: '$.A.N.T.E.R.Í.A',
          duration: '3:53'
        },
        {
          songName: 'Tren a Vapor',
          duration: '2:18'
        },
        {
          songName: "Roca N' Ron",
          duration: '2:37'
        },
        {
          songName: 'Par de Pepas',
          duration: '2:33'
        },
        {
          songName: 'Otras Cosas',
          duration: '2:31'
        }
      ]
    },
    {
      title: 'Serenata Sin Mariachis',
      dateCreated: new Date("2016-08-10T05:00:00.000Z"),
      songs: [
        {
          songName: 'Dando Saltos',
          duration: '2:17'
        },
        {
          songName: '6 30',
          duration: '2:03'
        },
        {
          songName: 'El Silencio Es Mío',
          duration: '2:20'
        },
        {
          songName: 'De Memoria',
          duration: '2:16'
        },
        {
          songName: 'Mala Hierba',
          duration: '3:09'
        }
      ]
    }
  ]
})

db.band.insertOne(
  {
  name: 'Daft Punk',
  country: 'France',
  url: 'https://daftpunk.com',
  albums: [
    {
      title: 'Random Access Memories',
      dateCreated: new Date("2013-05-17T05:00:00.000Z"),
      songs: [
        {
          songName: 'Give Live Back to Music',
          duration: '4:36'
        },
        {
          songName: 'Giorgio by Moroder',
          duration: '9:05'
        },
        {
          songName: 'Instant Crush',
          duration: '5:38'
        },
        {
          songName: 'Get Lucky',
          duration: '6:10'
        },
        {
          songName: 'Lose Yourself to Dance',
          duration: '5:53'
        }
      ]
    },
    {
      title: 'Discovery',
      dateCreated: new Date("2001-03-12T05:00:00.000Z"),
      songs: [
        {
          songName: 'One More Time',
          duration: '5:21'
        },
        {
          songName: 'Digital Love',
          duration: '4:58'
        },
        {
          songName: 'Harder, Better, Faster, Stronger',
          duration: '3:44'
        },
        {
          songName: 'Something About Us',
          duration: '3:49'
        },
        {
          songName: 'Veridis Quo',
          duration: '6:47'
        }
      ]
    }
  ]
  }
)

{
  _id: ObjectId('69095c55c6e883cf42e0b6a3'),
  name: 'Sonder',
  country: 'United States',
  albums: [
    {
      title: 'Into',
      dateCreated: 2017-01-27T05:00:00.000Z,
      songs: [
        {
          songName: 'Feel',
          duration: '3:53'
        },
        {
          songName: 'Lovely',
          duration: '4:52'
        },
        {
          songName: 'Sirens',
          duration: '3:19'
        },
        {
          songName: 'Too Fast',
          duration: '4:56'
        },
        {
          songName: 'Baldwin Park',
          duration: '1:36'
        }
      ]
    },
    {
      title: 'Too Young to Die Young',
      dateCreated: 2022-10-21T05:00:00.000Z
    }
  ]
}

name: 'The Score',
  country: 'United States',
  url: 'N/A',
  albums: [
    {
      title: 'Carry On',
      songs: [
        {
          songName: 'Can You Hear Me Now',
          duration: '3:15'
        },
        {
          songName: 'All of Me',
          duration: '2:44'
        },
        {
          songName: 'Golden',
          duration: '3:07'
        },
        {
          songName: 'Born for This',
          duration: '3:11'
        },
        {
          songName: 'Stronger',
          duration: '3:58'
        }
      ]
    },
    {
      title: 'ATLAS',
      songs: [
        {
          songName: 'Legend',
          duration: '3:10'
        },
        {
          songName: 'Only One',
          duration: '3:48'
        },
        {
          songName: 'Unstoppable',
          duration: '3:13'
        },
        {
          songName: 'Who I Am',
          duration: '3:52'
        },
        {
          songName: 'Miracle',
          duration: '3:27'
        }
      ]
    }
  ]
}

name: 'Tame Impala',
  country: 'Australia',
  albums: [
    {
      title: 'Currents',
      dateCreated: 2015-07-17T05:00:00.000Z,
      songs: [
        {
          songName: 'The Less I Know, The Better',
          duration: '3:37'
        },
        {
          songName: 'Let It Happen',
          duration: '7:48'
        },
        {
          songName: 'New Person, Same Old Mistakes',
          duration: '6:04'
        },
        {
          songName: "Yes I'm Changing",
          duration: '4:31'
        },
        {
          songName: 'Eventually',
          duration: '5:39'
        }
      ]
    },
    {
      title: 'The Slow Rush',
      dateCreated: 2020-02-14T05:00:00.000Z,
      songs: [
        {
          songName: 'Borderline',
          duration: '2:58'
        },
        {
          songName: 'One More Year',
          duration: '5:25'
        },
        {
          songName: 'One More Hour',
          duration: '7:13'
        },
        {
          songName: 'Instant Destiny',
          duration: '3:15'
        },
        {
          songName: 'Breathe Deeper',
          duration: '6:13'
        }
      ]
    }
  ]
}

// Punto 4

db.band.find()

// Punto 5

db.band.updateOne(
  {name: "Daft Punk"},
  {$unset: {"albums": ""}}
)

//Punto 6

db.band.updateOne(
  {name: "Tame Impala"},
  {$unset: {"albums.1.songs": ""}}
)

//Agregar campo ventas en todos los álbumes

db.band.updateOne(
  {name: "Tame Impala"},
  {$set: {"albums.1.sells": 1231412}}
)

db.band.updateOne(
  {name: "Tame Impala"},
  {$set: {"albums.0.sells": 1235312}}
)

db.band.updateOne(
  {name: "Daft Punk"},
  {$set: {"albums.1.sells": 9321938}}
)

db.band.updateOne(
  {name: "Daft Punk"},
  {$set: {"albums.0.sells": 9821938}}
)

db.band.updateOne(
  {name: "Sonder"},
  {$set: {"albums.1.sells": 12203}}
)

db.band.updateOne(
  {name: "Sonder"},
  {$set: {"albums.0.sells": 15203}}
)

db.band.updateOne(
  {name: "The Score"},
  {$set: {"albums.1.sells": 1520300}}
)

db.band.updateOne(
  {name: "The Score"},
  {$set: {"albums.0.sells": 1220300}}
)

db.band.updateOne(
  {name: "Métricas Frías"},
  {$set: {"albums.1.sells": 400051}}
)

db.band.updateOne(
  {name: "Métricas Frías"},
  {$set: {"albums.0.sells": 820051}}
)

// Mostrar la suma de ventas por banda y ordenar de mayor a menor

db.band.aggregate(
  [
    {$unwind: "$albums"}, {$group: {_id: "$name", totalSells: {$sum: "$albums.sells"}}}, {$sort: {totalSells: -1}}
  ]
)

//Mostrar la suma de ventas por países

db.band.aggregate(
  [
    {$unwind: "$albums"}, {$group: {_id: "$country", totalSells: {$sum: "$albums.sells"}}}, {$sort: {totalSells: -1}}
  ]
)