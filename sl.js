const countryFullList = require('./data/country-data.json')
const langNames = require('./data/language-codes_json.json')
const countryNames = require('./data/data_json.json')
const countryMirrorList = require('./data/mirror_countries.json')

const getLangNameByCode = (code) => {
  const langItem = langNames.find(item => item.alpha2 === code)
  if (langItem && langItem['English']) {
    return langItem['English']
  } else {
    console.warn(`Name for language code '${code}' isn't exist`)
    return ''
  }
}

const getCountryNameByCode = (code) => {
  const countryItem = countryNames.find(item => item.Code === code)
  if (countryItem && countryItem['Name']) {
    return countryItem['Name']
  } else {
    console.warn(`Name for country code '${code}' isn't exist`)
    return ''
  }
}

const countryList = countryFullList
  .filter(country => country['Languages'] !== null)
  .map(country => {
    const defaultLangCodes = ['en']
    const name = getCountryNameByCode(country['ISO3166-1-Alpha-2'])
    const code = country['ISO3166-1-Alpha-2']
    const langs = typeof country['Languages'] === 'string'
      ? country['Languages']
          // Create array of language codes
          .split(',')
          // Remove country code
          .map(lang => lang.split('-')[0])
          // Only ISO 639-1 codes
          .filter(lang => lang.length === 2)
          // Check code exist
          .filter(lang => getLangNameByCode(lang) !== '')
      : defaultLangCodes

    return {
      name,
      code,
      langs: langs.length > 0 ? langs : defaultLangCodes
    }
  })
  .sort((a,b) => {
    if (a.name < b.name) {
      return -1;
    }
    if (a.name > b.name) {
      return 1;
    }
    // a must be equal to b
    return 0;
  })

const countryChoicesTpl = '  choices:\n    ' + countryList
  .map(item => `"${item.name}": "${item.code}"`)
  .join('\n    ')

const langChoicesTpl = '  choices:\n    ' + langNames
  .map(item => `"${item.English}": "${item.alpha2}"`)
  .join('\n    ')

const prefLang = Object.fromEntries(countryList.map(c => ([c.code, c.langs[0]])))

console.log(JSON.stringify(prefLang))
