{if !$oUserCurrent}
	<div class="login-form">
		<a href="#" class="close" onclick="hideLoginForm(); return false;"></a>
		
		<form action="{router page='login'}" method="POST">
			<h3>{$aLang.user_authorization}</h3>

			{hook run='form_login_popup_begin'}

			<p><label>{$aLang.user_login}:<br />
			<input type="text" class="input-text" name="login" id="login-input"/></label></p>
			
			<p><label>{$aLang.user_password}:<br />
			<input type="password" name="password" class="input-text" /></label></p>
			
			<p><label><input type="checkbox" name="remember" class="checkbox" checked />{$aLang.user_login_remember}</label></p>

			{hook run='form_login_popup_end'}

			<input type="submit" name="submit_login" value="{$aLang.user_login_submit}" /><br /><br />
			
			<a href="{router page='login'}reminder/">{$aLang.user_password_reminder}</a><br />
			<a href="{router page='registration'}">{$aLang.user_registration}</a>
		</form>
	</div>
{/if}


<div id="header">
	{*<div class="profile">
		{if $oUserCurrent}
		{else}
			
		{/if}
	</div>*}

	
	<h1><a href="{cfg name='path.root.web'}">Livestreet Blog</a></h1>
	<h2>{cfg name="view.name"}</h2>
</div>


<div id="image"></div>


<ul class="pages">
	<li {if $sMenuHeadItemSelect=='index'}class="active"{/if}><a href="{router page='index'}">{$aLang.main}</a></li>					
	<!--<li><a href="#">{$aLang.main}</a>
		<ul>
			<li><a href="#">Subpage</a></li>
			<li><a href="#">Subpage</a></li>
			<li><a href="#">Subpage</a></li>
		</ul>
	</li>	-->				
	{hook run='main_menu'}
</ul>