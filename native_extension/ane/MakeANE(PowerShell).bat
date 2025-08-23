adt -package -target ane PoolakeyPayment.ane extension_android.xml `
  -swc Poolakey.swc `
  -platform Android-ARM   -C Android-ARM   . `
  -platform Android-ARM64 -C Android-ARM64 . `
  -platform Android-x86   -C Android-x86   . `
  -platform default       -C .             library.swf