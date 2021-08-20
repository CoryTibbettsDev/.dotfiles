# Firefox Settings
You can configure Firefox through the user.js in your profile folder.
Profile folders are name like:<br  />
`~/.mozilla/firefox/random.profile-name`.<br  />
The profile name is proceeded by a random string then a dot.
The default profile is `random.default-release`.
This is not to be confused with `random.default`
which is also created but not used? Idk why this is.
The default folder can be found automatically despite the random string with:<br  />
`variable="$(find $HOME/.mozilla/firefox/ -type d -path *.default-release)"`<br  />
(Sometimes it is named default-esr could be another permutation of default-something)<br  />
You can then copy your user.js into this folder and the settings will take effect.
It is also possible to create a new profile then change the default profile and copy user.js.
Unfortunately I have not found a way to automate this.
You can create a new profile with:<br  />
`firefox -CreatProfile profile-name`<br  />
But I have not found a command to change the default profile.
Firefox command line options appear to be poorly documented.

## user.js Examples
[Github arkenfox/user.js](https://github.com/arkenfox/user.js)
[Github pyllyukko/user.js](https://github.com/pyllyukko/user.js)
[Github yokoffing/Better-Fox](https://github.com/yokoffing/Better-Fox)
