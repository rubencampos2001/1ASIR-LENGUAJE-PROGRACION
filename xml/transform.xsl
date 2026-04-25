<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Reparaciones Rubenshicar – Informe</title>
        <link rel="stylesheet" href="../css/estilo.css"/>
      </head>
      <body>

        <header>
          <h1>🔧 Reparaciones Rubenshicar</h1>
          <p class="subtitulo">
            <xsl:value-of select="taller/@localidad"/> |
            Telf: <xsl:value-of select="taller/@telefono"/>
          </p>
          <p class="fecha-gen">Informe generado: <xsl:value-of select="substring(string(current-dateTime()), 1, 10)"/></p>
        </header>

        <nav>
          <a href="#pendiente">⏳ Pendientes</a>
          <a href="#en_progreso">🔨 En progreso</a>
          <a href="#entregado">✅ Entregados</a>
          <a href="#mecanicos">👷 Mecánicos</a>
        </nav>

        <main>

          <section id="pendiente">
            <h2>⏳ Pendientes</h2>
            <xsl:call-template name="tabla-reparaciones">
              <xsl:with-param name="estado">pendiente</xsl:with-param>
            </xsl:call-template>
          </section>

          <section id="en_progreso">
            <h2>🔨 En progreso</h2>
            <xsl:call-template name="tabla-reparaciones">
              <xsl:with-param name="estado">en_progreso</xsl:with-param>
            </xsl:call-template>
          </section>

          <section id="entregado">
            <h2>✅ Entregados</h2>
            <xsl:call-template name="tabla-reparaciones">
              <xsl:with-param name="estado">entregado</xsl:with-param>
            </xsl:call-template>
          </section>

          <section id="mecanicos">
            <h2>👷 Mecánicos</h2>
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Nombre</th>
                  <th>Especialidad</th>
                  <th>Turno</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="taller/mecanicos/mecanico">
                  <tr>
                    <td><xsl:value-of select="@id"/></td>
                    <td><xsl:value-of select="nombre"/></td>
                    <td><xsl:value-of select="@especialidad"/></td>
                    <td><xsl:value-of select="turno"/></td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </section>

        </main>

        <footer>
          <p>© 2024 Reparaciones Rubenshicar – Todos los derechos reservados</p>
        </footer>

      </body>
    </html>
  </xsl:template>

  <!-- Plantilla reutilizable: filtra reparaciones por el atributo estado -->
  <xsl:template name="tabla-reparaciones">
    <xsl:param name="estado"/>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Matrícula</th>
          <th>Vehículo</th>
          <th>Cliente</th>
          <th>Mecánico</th>
          <th>Fecha entrada</th>
          <th>Descripción</th>
          <th>Presupuesto</th>
        </tr>
      </thead>
      <tbody>
        <!-- estado ahora es atributo, no elemento -->
        <xsl:for-each select="taller/reparaciones/reparacion[@estado=$estado]">
          <tr>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="matricula"/></td>
            <td>
              <xsl:value-of select="marca"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="modelo"/>
            </td>
            <td><xsl:value-of select="cliente"/></td>
            <!-- ref del mecanico_ref apunta al id del mecanico -->
            <td><xsl:value-of select="mecanico_ref/@ref"/></td>
            <td><xsl:value-of select="fecha_entrada"/></td>
            <td><xsl:value-of select="descripcion"/></td>
            <td><xsl:value-of select="presupuesto"/> €</td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>

</xsl:stylesheet>
