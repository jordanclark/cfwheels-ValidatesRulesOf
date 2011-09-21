<cfparam name="arguments.dataType" type="string" default="">
<cfparam name="arguments.dataError" type="string" default="detailed">

<cfswitch expression="#arguments.dataType#">
	
	<cfcase value="Decimal">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -10^38+1 OR arguments.value GT 10^38-1>
			<cfset arguments.message = "SQL Decimal">
		</cfif>
	</cfcase>
	<cfcase value="Float">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -1.79E+308 OR arguments.value GT 1.79E+308>
			<cfset arguments.message = "SQL Float">
		</cfif>
	</cfcase>
	<cfcase value="Real">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -3.40E+38 OR arguments.value GT 3.40E+38>
			<cfset arguments.message = "SQL Real">
		</cfif>
	</cfcase>
	
	<cfcase value="BigInt">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -9223372036854775808 OR arguments.value GT 9223372036854775807>
			<cfset arguments.message = "SQL BigInt">
		</cfif>
	</cfcase>
	<cfcase value="Int">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -2147483648 OR arguments.value GT 2147483647>
			<cfset arguments.message = "SQL Int">
		</cfif>
	</cfcase>
	<cfcase value="SmallInt">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -32768 OR arguments.value GT 32767>
			<cfset arguments.message = "SQL SmallInt">
		</cfif>
	</cfcase>
	<cfcase value="TinyInt">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT 0 OR arguments.value GT 255>
			<cfset arguments.message = "SQL TinyInt">
		</cfif>
	</cfcase>

	<cfcase value="Money">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -9223372036854775808 OR arguments.value GT 9223372036854775807>
			<cfset arguments.message = "SQL Money">
		</cfif>
	</cfcase>
	<cfcase value="SmallMoney">
		<cfif NOT isNumeric( arguments.value ) OR arguments.value LT -214748.3648 OR arguments.value GT 214748.3647>
			<cfset arguments.message = "SQL SmallMoney">
		</cfif>
	</cfcase>
	
	<cfcase value="Numeric">
		<cfif NOT isNumeric( arguments.value )>
			<cfset arguments.message = "SQL Numeric">
		</cfif>
	</cfcase>
	
	<cfcase value="Bit">
		<cfif arguments.value IS NOT 0 AND arguments.value IS NOT 1>
			<cfset arguments.message = "SQL Bit">
		</cfif>
	</cfcase>
	
	<cfcase value="DateTime">
		<cfif NOT isDate( arguments.value ) OR arguments.value LT "{ts '1753-01-01 00:00:00'}" OR arguments.value GT "{ts '9999-12-31 23:59:59'}">
			<cfset arguments.message = "SQL DateTime">
		</cfif>
	</cfcase>
	<cfcase value="SmallDateTime">
		<cfif NOT isDate( arguments.value ) OR arguments.value LT "{ts '1900-01-01 00:00:00'}" OR arguments.value GT "{ts '2079-06-06 23:59:00'}">
			<cfset arguments.message = "SQL SmallDateTime">
		</cfif>
	</cfcase>
	
	<cfcase value="Text">
		<cfparam name="arguments.maxLength" type="numeric" default="2147483647">
		<cfif NOT isSimpleValue( arguments.value ) OR len( arguments.value ) GT arguments.maxLength>
			<cfset arguments.message = "SQL Text">
		</cfif>
	</cfcase>
	<cfcase value="NText">
		<cfparam name="arguments.maxLength" type="numeric" default="1073741823">
		<cfif NOT isSimpleValue( arguments.value ) OR len( arguments.value ) GT arguments.maxLength>
			<cfset arguments.message = "SQL NText(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="VarChar">
		<cfparam name="arguments.maxLength" type="numeric" default="8000">
		<cfif NOT isSimpleValue( arguments.value ) OR len( arguments.value ) GT arguments.maxLength>
			<cfset arguments.message = "SQL VarChar(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="NVarChar">
		<cfparam name="arguments.maxLength" type="numeric" default="4000">
		<cfif NOT isSimpleValue( arguments.value ) OR len( arguments.value ) GT arguments.maxLength>
			<cfset arguments.message = "SQL NVarChar(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="Char">
		<cfparam name="arguments.maxLength" type="numeric" default="8000">
		<cfif NOT isSimpleValue( arguments.value ) OR len( arguments.value ) GT arguments.maxLength>
			<cfset arguments.message = "SQL Char(#arguments.maxLength#)">
		</cfif>
	</cfcase>
	<cfcase value="NChar">
		<cfparam name="arguments.maxLength" type="numeric" default="4000">
		<cfif NOT isSimpleValue( arguments.value ) OR len( arguments.value ) GT arguments.maxLength>
			<cfset arguments.message = "SQL NChar(#arguments.maxLength#)>">
		</cfif>
	</cfcase>
	
</cfswitch>

<cfif len( arguments.message )>
	<cfif arguments.dataError IS "detailed">
		<cfset arguments.message = "is not valid #arguments.message#">
	<cfelse>
		<cfset arguments.message = "is not a valid value">
	</cfif>
</cfif>