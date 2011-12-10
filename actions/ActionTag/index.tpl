{include file='header.tpl'}


<form action="" method="GET" onsubmit="return submitTags(this.tag.value);" class="tag-search">
	<input type="text" name="tag" value="{$sTag|escape:'html'}" />
</form>
<br />


{include file='topic_list.tpl'}
{include file='footer.tpl'}