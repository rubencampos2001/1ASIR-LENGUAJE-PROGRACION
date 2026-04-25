# Proyecto: Reparaciones Rubenshicar

## 1. ¿Qué datos representa el XML?

El XML contiene datos de un taller de reparaciones de coches:

- **Mecánicos:** 3 empleados con su especialidad (motor, electricidad, chapa)
- **Reparaciones:** 6 trabajos de clientes con estado (pendiente, en progreso, entregado)
- **Clientes:** Nombres y teléfonos de contacto
- **Presupuestos:** Coste de cada reparación

El archivo `datos.xml` sigue esta estructura:

```xml
<taller nombre="..." localidad="..." telefono="...">
  <mecanicos>
    <mecanico id="M01" especialidad="motor">
      <nombre>...</nombre>
      <turno>...</turno>
    </mecanico>
  </mecanicos>
  <reparaciones>
    <reparacion id="R001" estado="entregado">
      <matricula>...</matricula>
      <marca>...</marca>
      <modelo>...</modelo>
      <cliente>...</cliente>
      <telefono_cliente>...</telefono_cliente>
      <mecanico_ref ref="M01"/>
      <fecha_entrada>...</fecha_entrada>
      <fecha_salida>...</fecha_salida>  <!-- opcional -->
      <descripcion>...</descripcion>
      <presupuesto>...</presupuesto>
    </reparacion>
  </reparaciones>
</taller>
```

> El estado de cada reparación va como **atributo** en `<reparacion>` para que el DTD pueda restringirlo con una enumeración. El mecánico se referencia con `<mecanico_ref ref="M01"/>` usando IDREF para que el validador compruebe que el ID existe.

---

## 2. ¿Cómo se valida con el DTD?

El archivo `modelo.dtd` define las reglas de estructura:

- Atributo `especialidad` con enumeración: `motor | electricidad | chapa | general`
- Atributo `estado` con enumeración: `pendiente | en_progreso | entregado`
- `id` de tipo `ID` en mecánicos y reparaciones (valores únicos)
- `ref` de tipo `IDREF` en `mecanico_ref` (debe apuntar a un ID existente)
- `fecha_salida` es **opcional** (`?`) — las reparaciones abiertas no tienen fecha de salida

**Comando para validar (ejecutar desde la carpeta xml/):**

```powershell
cd xml
xmllint --noout --dtdvalid modelo.dtd datos.xml
```

**Resultado esperado — sin errores:**
```
(ninguna salida = el archivo es válido)
```

**Para ver los errores con el archivo incorrecto:**
```powershell
xmllint --noout --dtdvalid modelo.dtd datos_error.xml
```

**Errores que detecta el DTD en datos_error.xml:**
```
validity error : Value "pintura" for attribute especialidad ... not among enumerated set
validity error : Value "reparando" for attribute estado ... not among enumerated set
validity error : ID R001 already defined
validity error : IDREF attribute ref references an unknown ID "M99"
```

---

## 3. ¿Cómo ejecutar la transformación XSL y visualizar el HTML?

El archivo `transform.xsl` convierte el XML a HTML agrupando las reparaciones por estado.

**Generar el HTML desde el XML (ejecutar desde la carpeta xml/):**

```powershell
cd xml
xsltproc transform.xsl datos.xml > ../informe_generado.html
```

**Abrir en el navegador:**
```powershell
Start-Process ../informe_generado.html
```

El HTML generado contiene:
- Cabecera con nombre del taller, localidad y fecha de generación
- Tres tablas separadas: Pendientes, En progreso, Entregados
- Tabla de mecánicos con especialidad y turno
- Navegación con anclas para saltar entre secciones
- Estilos CSS responsive

---

## 4. ¿Dónde ver la evidencia?

El archivo `informe.html` en la raíz del proyecto contiene el reporte visual completo generado a partir de los datos XML. Se puede abrir directamente en cualquier navegador.

Los comandos de validación están documentados en la sección 2 de este informe y pueden ejecutarse con `xmllint` desde la carpeta `xml/`.

---

## 5. ¿Cómo encaja en el proyecto?

El XML actúa como **base de datos portátil** del sistema del taller:

- **Exportación:** Los datos se exportan a `datos.xml` y `datos.json`
- **Reporte:** La transformación XSLT genera un informe HTML navegable
- **JSON equivalente:** `datos.json` contiene la misma información para otras aplicaciones
- **Validación:** El DTD garantiza que los datos tienen estructura correcta

**Flujo del proyecto:**

```
datos.xml ──► transform.xsl ──► informe_generado.html (reporte visual)
          ──► modelo.dtd    ──► validación de estructura

datos.json ──► alternativa para otras aplicaciones
```

---

## Archivos del Proyecto

| Archivo | Carpeta | Descripción |
|---|---|---|
| datos.xml | xml/ | Datos principales del taller |
| modelo.dtd | xml/ | Esquema de validación DTD |
| transform.xsl | xml/ | Transformación XSLT a HTML |
| datos_error.xml | xml/ | Archivo con errores (prueba de DTD) |
| estilo.css | css/ | Estilos CSS responsive |
| datos.json | json/ | Datos en formato JSON |
| informe.html | raíz | Reporte HTML principal |
| Informe.md | docs/ | Este documento |

---

## Cómo usar

1. **Ver el reporte:** Abrir `informe.html` en el navegador
2. **Validar el XML correcto:** `xmllint --noout --dtdvalid modelo.dtd datos.xml`
3. **Ver errores detectados:** `xmllint --noout --dtdvalid modelo.dtd datos_error.xml`
4. **Generar HTML desde XML:** `xsltproc transform.xsl datos.xml > ../informe_generado.html`
5. **Ver los datos en JSON:** Abrir `json/datos.json`

---

**Proyecto completado – 1º ASIR | Lenguajes de Marcas y Sistemas de Gestión de Información**
