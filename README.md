# version
I realize there's a lot of projects called *version* on GitHub. This one's inspired by the versioning file system in OpenVMS. However, this one doesn't do it automatically like in OpenVMS. This particular implementation is invoked manually.

## Description
This is a set of scripts that is used to maintain numbered sequential backups.

## version.sh
A quick way to make a backup of your file with a sequential version number before you make any changes to it.

### Usage
```
version.sh file
```

## renum.sh
Renumbers the version sequence of the specified file.

### Usage
```
renum.sh file
```

## purge.sh
Deletes older versions (numbered sequences) of the specified file.

### Usage
```
purge.sh [-k n] file
```
n is the number of versions to keep.
