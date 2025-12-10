<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:template match="/">
        <svg width="900" height="600" xmlns="http://www.w3.org/2000/svg">
            
            <!-- Définitions pour les animations et gradients -->
            <defs>
                <linearGradient id="grad1" x1="0%" y1="0%" x2="0%" y2="100%">
                    <stop offset="0%" style="stop-color:#ff6b6b;stop-opacity:1" />
                    <stop offset="100%" style="stop-color:#ee5a6f;stop-opacity:1" />
                </linearGradient>
                <linearGradient id="grad2" x1="0%" y1="0%" x2="0%" y2="100%">
                    <stop offset="0%" style="stop-color:#4ecdc4;stop-opacity:1" />
                    <stop offset="100%" style="stop-color:#44a8a0;stop-opacity:1" />
                </linearGradient>
                <filter id="shadow">
                    <feDropShadow dx="2" dy="2" stdDeviation="3" flood-opacity="0.3"/>
                </filter>
            </defs>
            
            <!-- Fond -->
            <rect width="900" height="600" fill="#f8f9fa"/>
            
            <!-- Titre -->
            <text x="450" y="40" font-family="Arial" font-size="24" font-weight="bold" 
                text-anchor="middle" fill="#2c3e50">
                Températures des villes marocaines
            </text>
            
            <!-- Légende -->
            <rect x="650" y="60" width="20" height="20" fill="url(#grad1)"/>
            <text x="675" y="75" font-family="Arial" font-size="14" fill="#555">
                <xsl:value-of select="meteo/mesure[1]/@date"/>
            </text>
            
            <rect x="650" y="90" width="20" height="20" fill="url(#grad2)"/>
            <text x="675" y="105" font-family="Arial" font-size="14" fill="#555">
                <xsl:value-of select="meteo/mesure[2]/@date"/>
            </text>
            
            <!-- Axe Y -->
            <line x1="80" y1="150" x2="80" y2="520" stroke="#333" stroke-width="2"/>
            <!-- Axe X -->
            <line x1="80" y1="520" x2="850" y2="520" stroke="#333" stroke-width="2"/>
            
            <!-- Graduations axe Y -->
            <xsl:call-template name="drawYAxis"/>
            
            <!-- Label axe Y -->
            <text x="40" y="330" font-family="Arial" font-size="14" fill="#555" 
                transform="rotate(-90 40 330)">Température (°C)</text>
            
            <!-- Label axe X -->
            <text x="450" y="560" font-family="Arial" font-size="14" fill="#555" 
                text-anchor="middle">Villes</text>
            
            <!-- Histogrammes -->
            <xsl:apply-templates select="meteo/mesure[1]/ville"/>
            <xsl:apply-templates select="meteo/mesure[2]/ville" mode="second"/>
            
        </svg>
    </xsl:template>
    
    <!-- Template pour les graduations de l'axe Y -->
    <xsl:template name="drawYAxis">
        <xsl:param name="temp" select="0"/>
        <xsl:if test="$temp &lt;= 30">
            <line x1="75" y1="{520 - $temp * 12}" x2="80" y2="{520 - $temp * 12}" 
                stroke="#333" stroke-width="1"/>
            <text x="65" y="{525 - $temp * 12}" font-family="Arial" font-size="12" 
                fill="#555" text-anchor="end">
                <xsl:value-of select="$temp"/>
            </text>
            <xsl:call-template name="drawYAxis">
                <xsl:with-param name="temp" select="$temp + 5"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <!-- Template pour la première mesure -->
    <xsl:template match="ville">
        <xsl:variable name="pos" select="position()"/>
        <xsl:variable name="x" select="100 + ($pos - 1) * 90"/>
        <xsl:variable name="height" select="@temperature * 12"/>
        
        <!-- Barre -->
        <rect x="{$x}" y="{520 - $height}" width="35" height="{$height}" 
            fill="url(#grad1)" filter="url(#shadow)">
            <animate attributeName="height" from="0" to="{$height}" 
                dur="1s" fill="freeze" begin="{$pos * 0.1}s"/>
            <animate attributeName="y" from="520" to="{520 - $height}" 
                dur="1s" fill="freeze" begin="{$pos * 0.1}s"/>
        </rect>
        
        <!-- Valeur de température -->
        <text x="{$x + 17.5}" y="{510 - $height}" font-family="Arial" 
            font-size="12" font-weight="bold" fill="#333" text-anchor="middle">
            <xsl:value-of select="@temperature"/>°
            <animate attributeName="opacity" from="0" to="1" dur="0.5s" 
                fill="freeze" begin="{$pos * 0.1 + 0.8}s"/>
        </text>
        
        <!-- Nom de ville -->
        <text x="{$x + 17.5}" y="540" font-family="Arial" font-size="11" 
            fill="#555" text-anchor="middle" transform="rotate(-20 {$x + 17.5} 540)">
            <xsl:value-of select="@nom"/>
        </text>
    </xsl:template>
    
    <!-- Template pour la deuxième mesure -->
    <xsl:template match="ville" mode="second">
        <xsl:variable name="pos" select="position()"/>
        <xsl:variable name="x" select="140 + ($pos - 1) * 90"/>
        <xsl:variable name="height" select="@temperature * 12"/>
        
        <!-- Barre -->
        <rect x="{$x}" y="{520 - $height}" width="35" height="{$height}" 
            fill="url(#grad2)" filter="url(#shadow)">
            <animate attributeName="height" from="0" to="{$height}" 
                dur="1s" fill="freeze" begin="{$pos * 0.1 + 0.5}s"/>
            <animate attributeName="y" from="520" to="{520 - $height}" 
                dur="1s" fill="freeze" begin="{$pos * 0.1 + 0.5}s"/>
        </rect>
        
        <!-- Valeur de température -->
        <text x="{$x + 17.5}" y="{510 - $height}" font-family="Arial" 
            font-size="12" font-weight="bold" fill="#333" text-anchor="middle">
            <xsl:value-of select="@temperature"/>°
            <animate attributeName="opacity" from="0" to="1" dur="0.5s" 
                fill="freeze" begin="{$pos * 0.1 + 1.3}s"/>
        </text>
    </xsl:template>
    
</xsl:stylesheet>