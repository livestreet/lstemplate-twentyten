{$noShowNav}{if $menu and $sNav}
	<div id="menu">
		{if in_array($menu,$aMenuContainers)}{$aMenuFetch.$menu}{else}{include file="menu.$menu.tpl"}{/if}
	</div>
{/if}