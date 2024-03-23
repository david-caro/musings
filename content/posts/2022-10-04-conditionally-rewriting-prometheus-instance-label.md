---
title: "Conditionally Rewriting Prometheus Instance Label"
date: 2022-10-04T09:29:48+02:00
tags: [prometheus]
draft: false
---

Something curious found ot today, and I don't want to lose, is how to overwrite
the `instance` label in prometheus, specifically, we have an exporter
(openstack-exporter) that exposes some metrics, and it populates one label
**sometimes** named `hostname`.

But for several reasons when dealing with the metrics we only filter by
`instance`, problem is, that the `instance` metric is usually the address/name
of the target prometheus is pulling the metrics from, and is this case that does
not match the `hostname`.

Now, it seems simple right? What I what to do is (in pseudopython):

{{< highlight python "linenos=table" >}}
if hostname in labels:
    labels["instance"] = hostname
{{< / highlight >}}

Well... it is not that simple xd, but found a relatively nice way of doing it.

{{< highlight yaml "linenos=table" >}}
- job_name: myjob
  scheme: http
  file_sd_configs:
    - files:
      - "/srv/prometheus/labs/targets/myjob.yaml"
  metric_relabel_configs:
    - source_labels:
        - hostname
        - instance
      regex: "^([^;:]+);._|^;(._)"
      separator: ";"
      target_label: instance
      replacement: "$1"
{{< / highlight >}}

Some things to highlight:

- Using `relabel_configs` instead of `metric_relabel_configs` would not work, as
  the first runs **before** the metrics are gathered, so the `hostname` label is
  not there yet.
- The order of the labels in the `source_labels` array will match the order in
  which they are concatenated.
- The regex is applied to the concatenated labels.
- I'm implementing the fallback behavior with regexes (ouch!), by using the
  seprator (`;`) as an anchor to match one group or the other as `$1`.
