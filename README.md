# hts-scripts

The repo contains scripts to download and build tools required for [HTS](http://hts.sp.nitech.ac.jp/) synthesis demo.

## Preparation:

1. Manualy download into directory *./downloads_manual*:

- *HTK-3.4.1.tar.gz* from [htk.eng.cam.ac.uk](http://htk.eng.cam.ac.uk/download.shtml)

- *HDecode-3.4.1.tar.gz* from [htk.eng.cam.ac.uk](http://htk.eng.cam.ac.uk/download.shtml)

- *hts_engine_API-1.10.tar.gz* from [hts-engine.sourceforge.net/](http://hts-engine.sourceforge.net)

2. Download the rest and build using the make script:

```bash
make prepare_all -j4
```

3. Configure training tasks using the prepared tools. See *configure_cmu_arctic* task in [Makefile](Makefile)

---

## Author

- [bitbucket.org/airenas](https://bitbucket.org/airenas)
- [linkedin.com/in/airenas](https://www.linkedin.com/in/airenas/)

---

### License

Copyright © 2020, [Airenas Vaičiūnas](https://github.com/airenas).
Released under the [The 3-Clause BSD License](LICENSE).

---
