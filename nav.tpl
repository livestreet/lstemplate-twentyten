<div id="nav">	
	<ul class="pages">
		<li {if $sMenuHeadItemSelect=='index'}class="active"{/if}><a href="{cfg name='path.root.web'}">{$aLang.main}</a></li>
						
		{hook run='main_menu_tree'}
	</ul>
</div>