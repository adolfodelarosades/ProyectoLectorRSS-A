# Proyecto lector RSS

## Introducción

Vamos a crear un lector RSS de noticias en iOS usando una **tabla** y una **colección**, además de **una vista simple** para mostrar la información de la propia app.

La app constará de **tres pestañas** de forma obligatoria:

- Noticias
- Favoritos
- Acerca de

En el proyecto se propondrán retos a cumplir, siendo el nivel A el básico que habrá de realizar el alumno para obtener el aprobado en el curso. A partir de ahí, completar cualquier otro nivel supondrá una mejora en la nota.

## Lectura de los datos

Se deberán leer los datos de un **JSON** y tratarlo con **Codable** para cargar en un **struct** (o varios) que sean capaces de entender y crear la estructura de los mismos.

La **fuente de los datos** será la siguiente **URL** que será la fuente asíncrona de datos:

[Applecoding](https://applecoding.com/wp-json/wp/v2/posts)

Para mayor referencia, podéis consultar el **significado de los campos** en la siguiente **URL**:

[Significado de los campos](https://developer.wordpress.org/rest-api/reference/posts/)

Esta llamada devuelve los últimos **10 artículos** en un formato bastante extenso **en formato JSON**. El JSON tiene una estructura en formato array con corchetes al comienzo y al final y una estructura repetitiva.

Los datos básicos a recuperar serán:

* id
* date
* link
* title -> rendered
* content -> rendered
* excerpt -> rendered
* jetpack_featured_media_url

La **fecha** ha de ser de **tipo Date**, y para ello se usará la siguiente extensión y código:

```
extension DateFormatter {
  static let iso8601Full:DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
```

Al hacer el **Codable**, deberá hacerse creando una instancia de **JSONDecoder** así:

```
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
```

De esta forma, al poner el campo date de tipo Date, se interpretará directamente desde el String
hacia un Date y **podremos ordenar por fecha** (si lo necesitáramos) de forma más eficiente.

#### Nivel A:

* Se recuperarán los datos mínimos y se guardarán en un **array en memoria** para su posterior uso en la tablas correspondiente.

* La imagen destacada del artículo ha de recuperarse del **nodo jetpack_featured_media_url**.

#### Nivel B:

* Usando el **parámetro per_page** en la llamada de la URL que recupera el JSON, se pueden especificar más artículos que 10. **Implementar para que recupere 20** en vez de 10.
* El **campo author** del JSON es de tipo entero y representa un **código**. Los datos del autor se recuperan de una llamada secundaria a la **URL: https://applecoding.com/wp-json/wp/v2/users/**. Si queremos recuperar el autor con el código 1 accederemos a **https://applecoding.com/wp-json/wp/v2/users/1**. El JSON recuperado tiene otra estructura diferente **donde deberemos recuperar el nodo name**.
* Las **categorías del artículo** están en el **nodo Categories**, que es un array de tipo numérico. Cada número es un ID que hay que recuperar de forma específica usando la **URL: https://applecoding.com/wp-json/wp/v2/categories**. Si la categoría es la 304, hay que acceder a **https://applecoding.com/wp-json/wp/v2/categories/304** y recuperar una nueva estructura de dato **donde hemos de quedarnos con el nodo name**. **Recordad que puede haber más de una categoría y todas deben ser guardadas**.

#### Nivel C:

- Los datos recuperados del JSON se guardarán en un **modelo en Core Data** con las tablas **POSTS**, **AUTORES** y **CATEGORIAS**, con sus correspondientes relaciones.

## Tabla Posts

Se creará una tabla de contenido prototipo para mostrar las noticias recuperadas de los datos del servidor de Apple Coding.

#### Nivel A:

* Se creará la **tabla con celda prototipo de tipo BASIC**, con una **imagen a la izquierda** y el **textLabel a la derecha** con el título de la noticia.

#### Nivel B:

* Se creará la **tabla con celda prototipo personalizada** donde se verá el **título de la noticia**, la **imagen destacada a la izquierda** y el **extracto de la misma**. Ha de estar en una **celda que crezca** en función al tamaño del extracto (**campo excerpt**).

#### Nivel C:

* Se creará **la tabla con celda prototipo personalizada** donde se verá el **título de la noticia**, la **imagen destacada a la izquierda**, el **extracto** y deberá ir acompañado en la parte inferior de la **categoría o categorías**, así como el **autor** de la noticia. La **celda debe crecer dinámicamente en función del tamaño del extracto**.

En todos los casos deberá incluir la **capacidad de marcar como favorita una noticia** y que se **incluya en otra fuente**. **No se podrán borrar noticias ni recolocar**.

Si estamos haciendo los niveles **A y B** en los datos, **los favoritos irán en un array en memoria**. Si estamos en nivel **C**, **en tablas en Core Data**. Nivel **A y B recuperarán los datos de un array** y nivel **C de Core Data usando NSFetchedResultController**.

Cuando se **pulsa en una celda se nos traslada a ver la noticia**. Para ello hemos de usar una **vista tipo WKWebView en el detalle**. Arrastramos una **ventana WebKit View** desde los componentes hacia un **ViewController**, donde hemos de **importar la librería WebKit** porque si no dará error diciendo que no encuentra el tipo **WKWebView**.

La propiedad donde tengamos el **WKWebView** tiene un **método** llamado **loadHTMLString** al que podemos pasarle la cadena con el contenido de la noticia y la mostrará como contenido HTML en un navegador.

En los niveles **B y C** la ventana detalle con el WKWebView deberá tener un **botón de tipo favorito** en la barra de navegación, para poder marcar o desmarcar esta.

## Colección Favoritos

Se mostrará una vista de colección con los favoritos.

#### Nivel A:

Celdas iguales con la imagen del artículo de fondo y el título.

#### Nivel B:

Celdas como tarjetas que mostrarán el imagen, título y autor.

#### Nivel C:

Leerá los datos de Core Data

## Pantalla Acerca de

Esta pantalla es totalmente libre. El Nivel A básico deberá incluir el nombre y la versión de la app. A partir de ahí, dejad volar vuestra imaginación.
