<cfparam name="arguments.dateMin" type="string" default="">
<cfparam name="arguments.dateMax" type="string" default="">

<cfif len( arguments.dateMax ) AND len( arguments.dateMin )>
	<cfif arguments.value GT arguments.dateMax OR arguments.value LT arguments.dateMin>
		<cfset arguments.message = "must be between #dateFormat( arguments.dateMin, 'yyy-mm-dd' )# and #dateFormat( arguments.dateMax, 'yyy-mm-dd' )#">
	</cfif>

<cfelseif len( arguments.dateMax )>
	<cfif loc.actualLength GT arguments.dateMax>
		<cfset arguments.message = "must be before #dateFormat( arguments.dateMax, 'yyy-mm-dd' )#">
	</cfif>

<cfelseif len( arguments.dateMin )>
	<cfif loc.actualLength LT arguments.dateMin>
		<cfset arguments.message = "must be after #dateFormat( arguments.dateMin, 'yyy-mm-dd' )#">
	</cfif>

</cfif>

