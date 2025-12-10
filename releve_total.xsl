<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>Relevé Bancaire</title>
                <style>
                    * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    }
                    body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    padding: 20px;
                    min-height: 100vh;
                    }
                    .container {
                    max-width: 1000px;
                    margin: 0 auto;
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 10px 40px rgba(0,0,0,0.2);
                    overflow: hidden;
                    }
                    .header {
                    background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
                    color: white;
                    padding: 30px;
                    }
                    .header h1 {
                    font-size: 28px;
                    margin-bottom: 15px;
                    }
                    .info-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 15px;
                    margin-top: 15px;
                    }
                    .info-item {
                    background: rgba(255,255,255,0.1);
                    padding: 12px;
                    border-radius: 8px;
                    }
                    .info-label {
                    font-size: 12px;
                    opacity: 0.8;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    }
                    .info-value {
                    font-size: 18px;
                    font-weight: bold;
                    margin-top: 5px;
                    }
                    .content {
                    padding: 30px;
                    }
                    table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 20px;
                    }
                    th {
                    background: #3498db;
                    color: white;
                    padding: 15px;
                    text-align: left;
                    font-weight: 600;
                    text-transform: uppercase;
                    font-size: 12px;
                    letter-spacing: 1px;
                    }
                    td {
                    padding: 12px 15px;
                    border-bottom: 1px solid #ecf0f1;
                    }
                    tr:hover {
                    background-color: #f8f9fa;
                    }
                    .credit {
                    color: #27ae60;
                    font-weight: bold;
                    }
                    .debit {
                    color: #e74c3c;
                    font-weight: bold;
                    }
                    .montant {
                    text-align: right;
                    font-weight: 600;
                    }
                    .totaux {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                    gap: 20px;
                    margin-top: 30px;
                    }
                    .total-card {
                    padding: 20px;
                    border-radius: 10px;
                    color: white;
                    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                    }
                    .total-credit {
                    background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                    }
                    .total-debit {
                    background: linear-gradient(135deg, #ee0979 0%, #ff6a00 100%);
                    }
                    .total-solde {
                    background: linear-gradient(135deg, #4776e6 0%, #8e54e9 100%);
                    }
                    .total-label {
                    font-size: 14px;
                    opacity: 0.9;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    }
                    .total-value {
                    font-size: 32px;
                    font-weight: bold;
                    margin-top: 10px;
                    }
                    .badge {
                    display: inline-block;
                    padding: 4px 12px;
                    border-radius: 20px;
                    font-size: 11px;
                    font-weight: bold;
                    text-transform: uppercase;
                    }
                    .badge-credit {
                    background: #d4edda;
                    color: #155724;
                    }
                    .badge-debit {
                    background: #f8d7da;
                    color: #721c24;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Relevé Bancaire</h1>
                        <div class="info-grid">
                            <div class="info-item">
                                <div class="info-label">RIB</div>
                                <div class="info-value"><xsl:value-of select="releve/@RIB"/></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Date du relevé</div>
                                <div class="info-value"><xsl:value-of select="releve/dateReleve"/></div>
                            </div>
                            <div class="info-item">
                                <div class="info-label">Période</div>
                                <div class="info-value">
                                    <xsl:value-of select="releve/operations/@dateDebut"/> au 
                                    <xsl:value-of select="releve/operations/@dateFin"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="content">
                        <h2 style="color: #2c3e50; margin-bottom: 20px;"> Liste des opérations</h2>
                        
                        <table>
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Type</th>
                                    <th>Description</th>
                                    <th style="text-align: right;">Montant (DH)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="releve/operations/operation">
                                    <tr>
                                        <td><xsl:value-of select="@date"/></td>
                                        <td>
                                            <xsl:choose>
                                                <xsl:when test="@type='CREDIT'">
                                                    <span class="badge badge-credit">✓ Crédit</span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="badge badge-debit">✗ Débit</span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                        <td><xsl:value-of select="@description"/></td>
                                        <td class="montant">
                                            <xsl:choose>
                                                <xsl:when test="@type='CREDIT'">
                                                    <span class="credit">+<xsl:value-of select="@montant"/></span>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <span class="debit">-<xsl:value-of select="@montant"/></span>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        
                        <div class="totaux">
                            <div class="total-card total-credit">
                                <div class="total-label"> Total Crédits</div>
                                <div class="total-value">
                                    <xsl:value-of select="sum(releve/operations/operation[@type='CREDIT']/@montant)"/> DH
                                </div>
                            </div>
                            
                            <div class="total-card total-debit">
                                <div class="total-label"> Total Débits</div>
                                <div class="total-value">
                                    <xsl:value-of select="sum(releve/operations/operation[@type='DEBIT']/@montant)"/> DH
                                </div>
                            </div>
                            
                            <div class="total-card total-solde">
                                <div class="total-label"> Solde du compte</div>
                                <div class="total-value">
                                    <xsl:value-of select="releve/solde"/> DH
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>