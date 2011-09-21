<cfparam name="arguments.mask" type="string">
<cfparam name="arguments.maskError" type="string" default="normal">

<cfset arguments.hadError = false>

<cfloop index="loc.x" from="1" to="#len( arguments.mask )#" step="1">

	<cfset arguments.char = mid( arguments.value, loc.x, 1 )>
	<cfset arguments.mask = mid( arguments.mask, loc.x, 1 )>
	
	<cfif arguments.mask IS 9 OR arguments.mask IS 0>
		<cfif NOT isNumeric( arguments.char )>
			<cfset arguments.hadError = true>
			<cfset arguments.return = arguments.return & " A number was expected not [#arguments.char#] in position #loc.x#">
		</cfif>
	
	<cfelseif arguments.mask IS "A">
		<cfif NOT findNoCase( arguments.char, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1 )>
			<cfset arguments.hadError = true>
			<cfset arguments.return = arguments.return & " A letter was expected not [#arguments.char#] in position #loc.x#">
		</cfif>

	<cfelseif arguments.mask IS "X">
		<cfif NOT findNoCase( arguments.char, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", 1 )>
			<cfset arguments.hadError = true>
			<cfset arguments.return = arguments.return & " An alpha-numeric was expected not [#arguments.char#] in position #loc.x#">
		</cfif>
	
	<cfelseif arguments.mask IS " ">
		<cfif arguments.char>
			<cfset arguments.hadError = true>
			<cfset arguments.return = arguments.return & " a space was expected not [#arguments.char#] in position #loc.x#">
		</cfif>
	
	<cfelseif arguments.mask IS "-">
		<cfif arguments.char>
			<cfset arguments.hadError = true>
			<cfset arguments.return = arguments.return & " a hyphen was expected not [#arguments.char#] in position #loc.x#">
		</cfif>
	
	<cfelse>
		<cfif compareNoCase( arguments.mask, arguments.char ) IS NOT 0>
			<cfset arguments.hadError = true>
			<cfset arguments.return = arguments.return & " A [#arguments.mask#] was expected not [#arguments.char#] in position #loc.x#">
		</cfif>
	</cfif>
	
</cfloop>

<cfif arguments.hadError>
	<cfif arguments.maskError IS "detailed">
		<cfset arguments.message = "is invalid, #arguments.return#">
	<cfelse>
		<cfset arguments.message = "must match the mask ""#arguments.mask#""">
	</cfif>
</cfif>
