<cfparam name="arguments.listLength" type="string" default="">
<cfparam name="arguments.listMin" type="string" default="">
<cfparam name="arguments.listMax" type="string" default="">
<cfparam name="arguments.delimiters" type="string" default=",">

<cfif isNumeric( arguments.listLength )>
	<cfset arguments.listMin = "">
	<cfset arguments.listMax = "">
<cfelseif listLen( arguments.listLength, "-" ) IS 2>
	<cfset arguments.listMin = replace( listGetAt( arguments.listLength, 1, "-" ), "N", "" )>
	<cfset arguments.listMax = replace( listGetAt( arguments.listLength, 2, "-" ), "N", "" )>
</cfif>

<cfset loc.actualLength = listLen( arguments.value, arguments.delimiters )>

<cfif len( arguments.listMax ) AND len( arguments.listMin )>
	<cfif loc.actualLength GT arguments.listMax OR loc.actualLength LT arguments.listMin>
		<cfset arguments.message = "must be between #arguments.listMin#-#arguments.listMax# items long">
	</cfif>
<cfelseif len( arguments.listMax )>
	<cfif loc.actualLength GT arguments.listMax>
		<cfset arguments.message = "must be no more than #arguments.listMax# items long">
	</cfif>
<cfelseif len( arguments.listMin )>
	<cfif loc.actualLength LT arguments.listMin>
		<cfset arguments.message = "must be at least #arguments.listMin# items long">
	</cfif>
<cfelseif len( arguments.listLength )>
	<cfif loc.actualLength IS NOT arguments.listLength>
		<cfset arguments.message = "must be exactly #arguments.listLength# items long">
	</cfif>
<cfelse>
	<cfset $throw(type="Wheels.IncorrectArguments", message="The `listMin`, `listMax` or `listLength` argument is required but was not passed in" )>
</cfif>

