Hi!

This is the source code for my "blog", you can find the live version
[here](https://musings.dcaro.es).

## Adding a new page

```shell
my_title="Some fancy title"
hugo new "content/posts/$(date +%Y-%m-%d)-${my_title// /-}.md"
```
