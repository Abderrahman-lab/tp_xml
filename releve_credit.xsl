<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Opérations de Crédit</title>
                <style>
                    * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    }
                    body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                    padding: 20px;
                    min-height: 100vh;
                    }
                    .container {
                    max-width: 900px;
                    margin: 0 auto;
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 10px 40px rgba(0,0,0,0.3);
                    overflow: hidden;
                    }
                    .header {
                    background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
                    color: white;
                    padding: 30px;
                    text-align: center;
                    }
                    .header h1 {
                    font-size: 32px;
                    margin-bottom: 10px;
                    }
                    .header p {
                    font-size: 16px;
                    opacity: 0.9;
                    }
                    .info-bar {
                    background: #ecf0f1;
                    padding: 20px 30px;
                    display: flex;
                    justify-content: space-between;
                    flex-wrap: wrap;
                    gap: 15px;
                    }
                    .info-item {
                    display: flex;
                    flex-direction: column;
                    }
                    .info-label {
                    font-size: 12px;
                    color: #7f8c8d;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    margin-bottom: 5px;
                    }
                    .info-value {
                    font-size: 16px;
                    font-weight: bold;
                    color: #2c3e50;
                    }
                    .content {
                    padding: 30px;
                    }
                    .stats {
                    background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
                    color: white;
                    padding: 25px;
                    border-radius: 10px;
                    margin-bottom: 25px;
                    display: flex;
                    justify-content: space-around;
                    align-items: center;
                    flex-wrap: wrap;
                    gap: 20px;
                    }
                    .stat-item {
                    text-align: center;
                    }
                    .stat-label {
                    font-size: 14px;
                    opacity: 0.9;
                    margin-bottom: 8px;
                    }
                    .stat-value {
                    font-size: 36px;
                    font-weight: bold;
                    }
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    }
                    th {
                    background: #27ae60;
                    color: white;
                    padding: 15px;
                    text-align: left;
                    font-weight: 600;
                    text-transform: uppercase;
                    font-size: 12px;
                    letter-spacing: 1px;
                    }
                    td {
                    padding: 15px;
                    border-bottom: 1px solid #ecf0f1;
                    }
                    tr:hover {
                    background-color: #e8f8f5;
                    }
                    .montant {
                    text-align: right;
                    font-weight: bold;
                    color: #27ae60;
                    font-size: 18px;
                    }
                    .icon {
                    display: inline-block;
                    width: 40px;
                    height: 40px;
                    background: #d4edda;
                    border-radius: 50%;
                    text-align: center;
                    line-height: 40px;
                    font-size: 20px;
                    }
                    .empty-state {
                    text-align: center;
                    padding: 60px 20px;
                    color: #95a5a6;
                    }
                    .empty-state-icon {
                    font-size: 64px;
                    margin-bottom: 20px;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1> Opérations de Crédit</h1>
                        <p>Relevé des entrées d'argent sur votre compte</p>
                    </div>
                    
                    <div class="info-bar">
                        <div class="info-item">
                            <span class="info-label">RIB</span>
                            <span class="info-value"><xsl:value-of select="releve/@RIB"/></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Date du relevé</span>
                            <span class="info-value"><xsl:value-of select="releve/dateReleve"/></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Période</span>
                            <span class="info-value">
                                <xsl:value-of select="releve/operations/@dateDebut"/> - 
                                <xsl:value-of select="releve/operations/@dateFin"/>
                            </span>
                        </div>
                    </div>
                    
                    <div class="content">
                        <div class="stats">
                            <div class="stat-item">
                                <div class="stat-label">Nombre d'opérations</div>
                                <div class="stat-value">
                                    <xsl:value-of select="count(releve/operations/operation[@type='CREDIT'])"/>
                                </div>
                            </div>
                            <div class="stat-item">
                                <div class="stat-label">Total des crédits</div>
                                <div class="stat-value">
                                    <xsl:value-of select="sum(releve/operations/operation[@type='CREDIT']/@montant)"/> DH
                                </div>
                            </div>
                        </div>
                        
                        <xsl:choose>
                            <xsl:when test="count(releve/operations/operation[@type='CREDIT']) > 0">
                                <table>
                                    <thead>
                                        <tr>
                                            <th style="width: 50px;"></th>
                                            <th>Date</th>
                                            <th>Description</th>
                                            <th style="text-align: right;">Montant (DH)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="releve/operations/operation[@type='CREDIT']">
                                            <tr>
                                                <td>
                                                    <span class="icon">✓</span>
                                                </td>
                                                <td><xsl:value-of select="@date"/></td>
                                                <td><xsl:value-of select="@description"/></td>
                                                <td class="montant">
                                                    +<xsl:value-of select="@montant"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </xsl:when>
                            <xsl:otherwise>
                                <div class="empty-state">
                                    <div class="empty-state-icon">📭</div>
                                    <h3>Aucune opération de crédit</h3>
                                    <p>Il n'y a pas d'opérations de crédit pour cette période</p>
                                </div>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>