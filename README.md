# hts-scripts

The repo contains scripts to download and build tools required for [HTS](http://hts.sp.nitech.ac.jp/) synthesis demo.

Preparation:

1. Manualy download:

- *HTK-3.4.1.tar.gz* from [htk.eng.cam.ac.uk](http://htk.eng.cam.ac.uk/download.shtml) into *./downloads_manual*

- *HDecode-3.4.1.tar.gz* from [htk.eng.cam.ac.uk](http://htk.eng.cam.ac.uk/download.shtml) into *./downloads_manual*

- *hts_engine_API-1.10.tar.gz8 from [hts-engine.sourceforge.net/](http://hts-engine.sourceforge.net) into *./downloads_manual*

1. Download the rest and build: 

```bash
make prepare_all -j4
```

1. Configure training tasks using the prepared tools. See *configure_cmu_arctic* task in *Makefile*

---

## Author

### Airenas Vaičiūnas

* [bitbucket.org/airenas](https://bitbucket.org/airenas)
* [linkedin.com/in/airenas](https://www.linkedin.com/in/airenas/)

---

### License

Copyright © 2020, [Airenas Vaičiūnas](https://github.com/airenas).
Released under the [The 3-Clause BSD License](LICENSE).

---
