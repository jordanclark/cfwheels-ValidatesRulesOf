<cfparam name="arguments.length" type="string" default="">
<cfparam name="arguments.min" type="string" default="">
<cfparam name="arguments.max" type="string" default="">

<cfif NOT isArray( arguments.value )>
	<cfset arguments.message = "is not a valid array object">
<cfelse>
	<cfif isNumeric( arguments.length )>
		<cfset arguments.min = "">
		<cfset arguments.max = "">
	<cfelseif listLen( arguments.length, "-" ) IS 2>
		<cfset arguments.min = replace( listGetAt( arguments.length, 1, "-" ), "N", "" )>
		<cfset arguments.max = replace( listGetAt( arguments.length, 2, "-" ), "N", "" )>
	</cfif>
	
	<cfset loc.actualLength = arrayLen( arguments.value )>
	
	<cfif len( arguments.max ) AND len( arguments.min )>
		<cfif loc.actualLength GT arguments.max OR loc.actualLength LT arguments.min>
			<cfset arguments.message = "must be between #arguments.min#-#arguments.max# characters long">
		</cfif>
	<cfelseif len( arguments.max )>
		<cfif loc.actualLength GT arguments.max>
			<cfset arguments.message = "must be no more than #arguments.max# characters long">
		</cfif>
	<cfelseif len( arguments.min )>
		<cfif loc.actualLength LT arguments.min>
			<cfset arguments.message = "must be at least #arguments.min# characters long">
		</cfif>
	<cfelseif len( arguments.length )>
		<cfif loc.actualLength IS NOT arguments.length>
			<cfset arguments.message = "must be exactly #arguments.length# characters long">
		</cfif>
	<cfelse>
		<cfset $throw(type="Wheels.IncorrectArguments", message="The `min`, `max` or `length` argument is required but was not passed in" )>
	</cfif>
</cfif>
