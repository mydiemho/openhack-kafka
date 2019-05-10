# How to download html from Openhack website

1. Find the challenge's container class name.  In this case, it's `filldiv-old lab-body`
1. Inspect source, run following command in developer console to get html

```
document.documentElement.getElementsByClassName("filldiv-old lab-body")[0].innerHTML
```

1. Use pandoc to conver to markdown if desired