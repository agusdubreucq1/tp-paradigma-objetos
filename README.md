# TP Integrador - Paradigma Orientado a Objetos 2022

Integrantes:

- Ernestina Kerbs
- Nicolas Klaver
- Agustin Dubreucq
- Jasson A. M. Rodriguez

## Consignas

Este trabajo tiene consignas abiertas con la intención de que tomen decisiones sobre el diseño de la solución. También tiene las dimensiones y complejidad que podrían encontrar en un parcial, con lo cual debería servir para prepararse para lo que se viene :muscle:

Pueden encontrar el enunciado del trabajo práctico [acá](https://docs.google.com/document/d/1s50oo4afeUFyDxo8ypkNaEhPC0yy8IHuxq-IISOUq64/edit?usp=sharing).

Se espera que desarrollen lo indicado en cada punto en el archivo `src/modelo.wlk` y las pruebas correspondientes en `src/pruebas.wtest`.

Y no olviden editar este `README` con los nombres de cada integrante :smile:

## Modalidad de trabajo

Para arrancar, cada integrante debería clonarse el repositorio e importar el proyecto en el IDE de Wollok como hicieron para los mini TPs.

Al igual que para los trabajos prácticos anteriores, se recomienda dar pasos chicos: implementar lo que se pide para un punto, probar lo desarrollado para validar que funciona correctamente y subir esos cambios.

Una vez que hayan terminado su solución, no olviden de abrir un issue para avisar que entregaron el trabajo práctico y crear un **tag** en el repositorio para que las pruebas se ejecuten en el servidor, quedando los resultados disponibles para su revisión.

Si tienen dudas, recuerden que también pueden abrir un issue en este repositorio para pedir ayuda. 

### Testeo :heavy_check_mark:

Para este trabajo **no se proveen pruebas automáticas** que verifiquen los resultados de las operaciones a desarrollar en cada punto, para no comprometer la libertad para diseñar la solución. 

La implementación de las pruebas automáticas forma parte del trabajo práctico, ya que no sólo sirven para verificar que el programa funciona como esperan, sino que también complementa la solución pudiendo ver claramente cuál es el uso esperado y cómo se configura el sistema en base al modelo desarrollado.

Tengan en cuenta que podría ser necesario introducir cambios al modelo que pensaron a lo largo del desarrollo o luego de la entrega, con lo cual tener una cobertura suficiente de tests está bueno para tener algo sobre lo cual recaer para confirmar que lo que hicieron anteriormente todavía funciona.

Se pide desarrollar tests para cada requerimiento que permitan validar los distintos flujos del programa, lo cual incluye también pruebas de situaciones excepcionales si las hubieran.

:bulb: Se recomienda desarrollar tantos tests chicos y sencillos como consideren valiosos para validar mejor la solución de forma sencilla, en vez de limitarse sólo a testear la operación principal que resuelve el requerimiento pedido. Esto es especialmente importante si la interacción entre distintas combinaciones de objetos llevan a ejecutar lógica distinta.

> Las pruebas sólo se van a correr a través de GitHub Actions al crear un **tag** en el repositorio. Esto sirve para poder ver los resultados de las pruebas sin ejecutar el código localmente, así como facilitar la comparación del código entre distintas versiones importantes del trabajo, con lo cual ayuda que creen un tag al entregar el trabajo práctico y luego de alguna reentrega para su corrección.

Material de referencia sobre testeo para complementar lo visto en clase:
- Apuntes:
  - [Módulo 05: Introducción al testeo unitario automatizado.](https://docs.google.com/document/d/1Q_v48gZfRmVfLMvC0PBpmtZyMoALbh11AwmEllP__eY/edit?usp=sharing)
  - [Módulo 06: Objetos anónimos y repaso polimorfismo.](https://docs.google.com/document/d/1j2VoBNczPsMXrIjJ4tycYU982CZahReTvzkWS9TTKV0/edit?usp=sharing)
  - [Módulo 11: Testeo unitario automatizado avanzado.](https://docs.google.com/document/d/1caDE_mlP1QMfzyVpyvh-tKshjAeYLXBkXDYrTX5zFUI/edit?usp=sharing)
- [Documentación de Wollok](https://www.wollok.org/documentacion/wollokdoc/) (buscar el objeto assert en la sección **lib.wlk**)

### Recomendaciones para trabajo grupal :busts_in_silhouette:

Si bien no hay una única forma para trabajar en grupo sobre una misma base de código, la recomendación es que se coordinen para arrancar trabajando de forma **sincrónica** (juntándose de forma presencial o remota) de forma que puedan charlar y empezar a implementar lo pedido para tomar decisiones conjuntas, en especial sobre los primeros puntos. Luego repartirse mejoras y extensiones para trabajar de forma asincrónica debería ser más fácil.

Para trabajo **asincrónico**, alcanza con que cada integrante haya importado el proyecto en su entorno de Wollok y **antes** de trabajar sobre un cambio, se asegure de tener su repo local con el **código actualizado** usando la opción **Team -> Pull** del menú que se despliega haciendo click derecho en el proyecto.

En la medida en la que avancen sobre el ejercicio, asegúrense de subir su solución a GitHub para que los demás puedan bajarse los cambios realizados.

Eviten empezar un cambio y dejarlo sin subir, de lo contrario es muy probable que se produzcan [**conflictos**](https://www.youtube.com/watch?v=sKcN7cWFniw&list=PL2xYJ49ov_ddydw7wvncxMBzB3wpqPV0u&index=7) con lo que haga la otra persona :scream:

Siempre es mejor hacer commits chicos para cambios puntuales y pushear seguido, y más aún trabajando en equipo.
