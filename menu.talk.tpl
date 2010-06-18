<h2>{$aLang.talk_menu_inbox}</h2>

<ul class="switcher">					
	<li {if $sEvent=='inbox'}class="active"{/if}><a href="{router page='talk'}">{$aLang.talk_menu_inbox_list}</a></li>
	<li {if $sEvent=='add'}class="active"{/if}><a href="{router page='talk'}add/">{$aLang.talk_menu_inbox_create}</a></li>	
	{hook run='menu_talk'}
</ul>