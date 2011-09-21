<cfparam name="arguments.cardTypes" type="numeric" default="3">
<cfset cardType = [ "m,a,v,d", "mc,am,vi,ds", "mc,amex,visa,disc", "mastercard,amex,visa,discover" ]>

<cfif isNumeric( arguments.cardTypes )>
	<cfset searchList = cardType[ arguments.cardTypes ]>
<cfelse>
	<cfset searchList = lCase( arguments.cardTypes )>
</cfif>

<cfif NOT listFindNoCase( searchList, arguments.value )>
	<cfset arguments.message = "is not a valid credit card type">
</cfif>

