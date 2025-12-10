<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
        <xsl:template match="/">
            <html>
                <head>
                    <title>Relevés Météorologiques</title>
                    <style>
                        body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                        background-color: #f5f5f5;
                        }
                        h1 {
                        color: #2c3e50;
                        text-align: center;
                        }
                        .mesure {
                        background-color: white;
                        margin: 20px 0;
                        padding: 15px;
                        border-radius: 8px;
                        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                        }
                        .date {
                        font-size: 1.2em;
                        font-weight: bold;
                        color: #3498db;
                        margin-bottom: 10px;
                        }
                        table {
                        width: 100%;
                        border-collapse: collapse;
                        }
                        th {
                        background-color: #3498db;
                        color: white;
                        padding: 10px;
                        text-align: left;
                        }
                        td {
                        padding: 8px;
                        border-bottom: 1px solid #ddd;
                        }
                        tr:hover {
                        background-color: #f0f8ff;
                        }
                        .temp {
                        font-weight: bold;
                        color: #e74c3c;
                        }
                    </style>
                </head>
                <body>
                    <h1>Relevés Météorologiques du Maroc</h1>
                    <xsl:apply-templates select="meteo/mesure"/>
                </body>
            </html>
        </xsl:template>
        
        <xsl:template match="mesure">
            <div class="mesure">
                <div class="date">Date: <xsl:value-of select="@date"/></div>
                <table>
                    <tr>
                        <th>Ville</th>
                        <th>Température (°C)</th>
                    </tr>
                    <xsl:apply-templates select="ville"/>
                </table>
            </div>
        </xsl:template>
        
        <xsl:template match="ville">
            <tr>
                <td><xsl:value-of select="@nom"/></td>
                <td class="temp"><xsl:value-of select="@temperature"/>°C</td>
            </tr>
        </xsl:template>
        
</xsl:stylesheet>