<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">

  <xsl:output method="text" encoding="utf-8"/>

  <xsl:variable name='nl'>
    <xsl:text>&#xa;</xsl:text>
  </xsl:variable>

  <xsl:template match="/">

    <xsl:variable name="total_lines" select="count(/coverage/packages/package/classes/class/lines/line)" />
    <xsl:variable name="covered_lines" select="count(/coverage/packages/package/classes/class/lines/line[@hits!='0'])" />
    <xsl:variable name="coverage" select="($covered_lines * 100) div $total_lines"/>

    <xsl:text>##teamcity[buildStatisticValue key='OpenCppCoverage' value='</xsl:text>
    <xsl:value-of select="$coverage"/>
    <xsl:text>']</xsl:text>
    <xsl:value-of select="$nl"/>

    <!-- TeamCity built in coverage -->
    <xsl:text>##teamcity[buildStatisticValue key='CodeCoverageAbsLTotal' value='</xsl:text>
    <xsl:value-of select="$total_lines"/>
    <xsl:text>']</xsl:text>
    <xsl:value-of select="$nl"/>

    <xsl:text>##teamcity[buildStatisticValue key='CodeCoverageAbsLCovered' value='</xsl:text>
    <xsl:value-of select="$covered_lines"/>
    <xsl:text>']</xsl:text>
    <xsl:value-of select="$nl"/>

  </xsl:template>
</xsl:stylesheet>
