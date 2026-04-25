# Reparaciones Rubenshicar - 1º ASIR

## Estructura del Proyecto

```
IntermodularPRO/
├── xml/
│   ├── datos.xml           ✅ Datos XML válidos
│   ├── modelo.dtd          ✅ Esquema de validación DTD
│   ├── transform.xsl       ✅ Transformación a HTML
│   └── datos_error.xml     ⚠️  Archivo con errores (prueba de validación)
├── css/
│   └── estilo.css          ✅ Estilos CSS responsive
├── json/
│   └── datos.json          ✅ Datos en formato JSON
├── docs/
│   └── Informe.md          ✅ Documentación completa
├── informe.html            ✅ Reporte principal (abrir en navegador)
└── README.md               ← Este archivo
```

## Inicio Rápido

### Ver el reporte visual
```powershell
Start-Process informe.html
```

### Validar el XML correcto
```powershell
cd xml
xmllint --noout --dtdvalid modelo.dtd datos.xml
```

### Ver errores que detecta el DTD
```powershell
cd xml
xmllint --noout --dtdvalid modelo.dtd datos_error.xml
```

### Generar HTML desde el XML con XSLT
```powershell
cd xml
xsltproc transform.xsl datos.xml > ../informe_generado.html
Start-Process ../informe_generado.html
```

## Contenido del proyecto

- **3 mecánicos** con especialidades distintas (motor, electricidad, chapa)
- **6 reparaciones** en diferentes estados (pendiente, en progreso, entregado)
- **Validación DTD** con restricciones reales: enumeraciones, IDs, IDREFs
- **Transformación XSLT** que genera un informe HTML agrupado por estado
- **CSS moderno** y responsive
- **JSON equivalente** con los mismos datos

## Documentación

Ver `docs/Informe.md` para más detalle sobre:
- Qué datos representa el XML
- Cómo se valida con el DTD
- Cómo ejecutar la transformación XSLT
- Cómo encaja en el proyecto intermodular

---

**Proyecto listo para presentación – 1º ASIR | Lenguajes de Marcas**
