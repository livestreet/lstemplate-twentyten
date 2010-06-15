{include file='header.tpl' menu="profile"}


<h4>{$aLang.author_topics}: <span>{$oUserProfile->getProfileName()} ({$oUserProfile->getLogin()})</span></h4>

<div class="author-info">
	<a href="{$oUserProfile->getUserWebPath()}"><img src="{$oUserProfile->getProfileAvatarPath(48)}" alt="avatar" class="avatar" /></a>
	<strong>{$aLang.about_author} {$oUserProfile->getProfileName()}</strong><br />
	<strong>{$aLang.author_nickname}:</strong> {$oUserProfile->getLogin()}<br />
	{$oUserProfile->getProfileAbout()}<br />
</div>


{include file='topic_list.tpl'}
{include file='footer.tpl'}

