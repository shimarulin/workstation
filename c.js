fetch('https://archlinux.org/mirrors/status/json/')
  .then(response => response.json())
  .then(mirrors => mirrors.urls)
  .then(urls => {
    const a = urls
      .map(({country, country_code}) => ({country, country_code}))
      .reduce((acc, item) => {
        if (!acc.find(({country}) => country === item.country )) {
          acc.push(item)
        }

        return acc
      }, [])
      .sort((a,b) => {
        if (a.country < b.country) {
          return -1;
        }
        if (a.country > b.country) {
          return 1;
        }
        // a must be equal to b
        return 0;
      })
      .map(i => ({code: i.country_code, name: i.country}))
//      .map(i => ([i.country_code, {country_code: i.country_code, country_name: i.country}]))

//    return Object.fromEntries(a)
    return a
  })
  .then(map => {
    console.log(JSON.stringify(map))
//    console.log(map)
  })


