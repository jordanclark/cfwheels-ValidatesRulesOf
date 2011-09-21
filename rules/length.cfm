<!--- more intuitive naming --->
<cfif NOT structKeyExists( arguments, "lengthUnits" )>
	<cfif listFindNoCase( arguments.rules, "integer" )
		OR listFindNoCase( arguments.rules, "number" )
		OR listFindNoCase( arguments.rules, "dollar" )
		OR listFindNoCase( arguments.rules, "creditcard" )
		OR listFindNoCase( arguments.rules, "ean" )
		OR listFindNoCase( arguments.rules, "upc" )
		OR listFindNoCase( arguments.rules, "zipcode" )
	>
		<cfset arguments.lengthUnits = "number">
	</cfif>
</cfif>

<cfparam name="arguments.length" type="string" default="">
<cfparam name="arguments.lengthUnits" type="string" default="character">
<cfparam name="arguments.min" type="string" default="">
<cfparam name="arguments.max" type="string" default="">

<cfif isNumeric( arguments.length )>
	<cfset arguments.min = "">
	<cfset arguments.max = "">
<cfelseif listLen( arguments.length, "-" ) IS 2>
	<cfset arguments.min = replace( listGetAt( arguments.length, 1, "-" ), "N", "" )>
	<cfset arguments.max = replace( listGetAt( arguments.length, 2, "-" ), "N", "" )>
</cfif>

<cfset loc.actualLength = len( arguments.value )>

<cfif len( arguments.max ) AND len( arguments.min )>
	<cfif loc.actualLength GT arguments.max OR loc.actualLength LT arguments.min>
		<cfif arguments.mutable>
			<cfset arguments.value = left( arguments.value, arguments.max )>
		</cfif>
		<cfset arguments.message = "must be between #arguments.min#-#arguments.max# #arguments.lengthUnits#s long">
	</cfif>

<cfelseif len( arguments.max )>
	<cfif loc.actualLength GT arguments.max>
		<cfif arguments.mutable>
			<cfset arguments.value = left( arguments.value, arguments.max )>
		</cfif>
		<cfif arguments.max IS 1>
			<cfset arguments.message = "must be no more than #arguments.max# #arguments.lengthUnits# long">
		<cfelse>
			<cfset arguments.message = "must be no more than #arguments.max# #arguments.lengthUnits#s long">
		</cfif>
	</cfif>

<cfelseif len( arguments.min )>
	<cfif loc.actualLength LT arguments.min>
		<cfif arguments.min IS 1>
			<cfset arguments.message = "must be at least #arguments.min# #arguments.lengthUnits# long">
		<cfelse>
			<cfset arguments.message = "must be at least #arguments.min# #arguments.lengthUnits#s long">
		</cfif>
	</cfif>

<cfelseif len( arguments.length )>
	<cfif loc.actualLength IS NOT arguments.length>
		<cfif arguments.mutable>
			<cfset arguments.value = left( arguments.value, arguments.length )>
		</cfif>
		<cfif arguments.min IS 1>
			<cfset arguments.message = "must be exactly #arguments.length# #arguments.lengthUnits# long">
		<cfelse>
			<cfset arguments.message = "must be exactly #arguments.length# #arguments.lengthUnits#s long">
		</cfif>
	</cfif>

<cfelse>
	<cfset $throw(type="Wheels.IncorrectArguments", message="The `min`, `max` or `length` argument is required but was not passed in" )>
</cfif>
