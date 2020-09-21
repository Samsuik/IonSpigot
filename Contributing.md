Contributing to Ion _Spigot_
==========================
Ion has a very lenient policy towards PRs, but would prefer that you try and adhere to the following guidelines.

## Understanding Patches
Patches to Ion are very simple, but centes around the directories 'IonSpigot-API' and 'IonSpigot-Server'

Assuming you already have forked the repository:

1. Pull the latest changes from the main repository
2. Type `./applyPatches.sh` in git bash to apply the changes from upstream
3. cd into `IonSpigot-Server` for server changes, and `IonSpigot-API` for api changes

These directories aren't git repositories in the traditional sense:

- Every single commit in IonSpigot-Server/API is a patch. 
- 'origin/master' points to a directory similar to IonSpigot-Server/API but for PaperSpigot
- Typing `git status` should show that we are 10 or 11 commits ahead of master, meaning we have 10 or 11 patches that PaperSpigot and Spigot don't
  - If it says something like `212 commits ahead, 207 commits behind`, then type `git fetch` to update spigot/paperspigot

## Adding Patches
Adding patches to Ion is very simple:

1) Modify `IonSpigot-Server` and/or `IonSpigot-API` with the appropriate changes
2) Type `git add .` to add your changes
3) Run `git commit` with the desired patch message
4) Run `./rebuildPatches.sh` in the main directory to convert your commit into a new patch
5) PR your patches on github

Your commit will be converted into a patch that you can then PR into Ion

## Modifying Patches
Modifying previous patches is a bit more complex:

1) Make sure `git status` is correct
  - If it says something like `212 commits ahead, 207 commits behind`, then type `git fetch` to update spigot/paperspigot
2) If you have changes you are working on type `git stash` to store them for later
  - Later you can type `git stash pop` to get them back
3) Type `git rebase -i`
  - It should show something like [this](http://hastebin.com/toxohutocu.hs)
4) Replace `pick` with `edit` for the commit/patch you want to modify, and "save" the changes
  - Only do this for one commit until you get more advanced and understand what `git rebase -i` does
5) Make the changes you want to make to the patch
6) Type `git add .` to add your changes
7) Type `git commit --amend` to commit
  - **MAKE SURE TO ADD `--amend`** or else a new patch will be created
  - You can also modify the commit message here
8) Type `git rebase --continue` to finish rebasing
9) Type `./rebuildPatches.sh` in the main directory
  - This will modify the appropriate patches based on your commits
10) PR your modifications to github

## PR Policy
We'll accept changes that make sense. You should be able to justify their existence, along with any maintenance costs that come with them. 

Remember, these changes will affect everyone who runs Ion, not just you and your server.

While we will fix minor formatting issues, you should stick to the guide below when making and submitting changes.


## Formatting
All modifications to non-Ion files should be marked
- Multi line changes start with `// IonSpigot start` and end with `// IonSpigot end`
- You can put a messages with a change if it isn't obvious, like this: `// IonSpigot start - reason
  - Should generaly be about the reason the change was made, what it was before, or what the change is
  - Multi-line messages should start with `// IonSpigot start` and use `/* Multi line message here */` for the message itself
- Single line changes should have `// IonSpigot` or `// IonSpigot - reason`
- For example:
````java
entity.getWorld().dontbeStupid(); // IonSpigot - was beStupid() which is bad
entity.getFriends().forEach(Entity::explode());
entity.a();
entity.b();
// IonSpigot start - use plugin-set spawn
// entity.getWorld().explode(entity.getWorld().getSpawn());
Location spawnLocation = ((CraftWorld)entity.getWorld()).getSpawnLocation();
entity.getWorld().explode(new BlockPosition(spawnLocation.getX(), spawnLocation.getY(), spawnLocation.getZ()));
// IonSpigot end
````
- We generally follow usual java style, or what is programmed into most IDEs and formatters by default
  - This is also known as oracle style
  - It is fine to go over 80 lines as long as it doesn't hurt readability
