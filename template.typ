#let template(
  title: none,
  article-kind: "Bachelorarbeit",
  author: (
    name: none,
    matriculation-number: none,
    major: none,
  ),
  company: (
    name: none,
    city: none,
    logo: none,
    supervisor: none,
  ),
  dhbw: (
    reviewer: none,
  ),
  signature: (
    location: none,
    date: datetime.today(),
  ),
  deadline: none,
  handling-period: none,
  restriction-note: false,
  language: "de",
  abstract: none,
  acronyms: none,
  body
) = {
  let translations = (
    "de": (
      "abstract": "Zusammenfassung",
      "acronyms": "Abkürzungen",
    ),
    "en": (
      "abstract": "Abstract",
      "acronyms": "Acronyms",
    )
  ).at(language)

  set document(title: title, author: author.name)
  set page(
    paper: "a4",
    margin: 2.5cm,
  )
  
  set text(lang: "de", font: ("Libertinus Serif", "Linux Libertine"))

  show link: set text(fill: blue.darken(60%))

  // Title Page
  {
    grid(
      row-gutter: 1fr,
      block(
        height: 2.5cm,
        grid(
          columns: 2,
          column-gutter: 1fr,
          align(left, company.logo),
          align(right, image("dhbw-logo.svg")),
        )
      ),
      align(horizon + center)[
        #text(size: 20pt, lang: language, title) \
        #v(1.5cm)

        #set text(14pt)
        
        #article-kind \
        #v(1cm)
        des Studienganges #author.major \
        an der Dualen Hochschule Baden-Württemberg #dhbw.location \
        #v(1cm)
        von \
        #author.name \
        #v(1cm)
        #deadline.display("[day].[month].[year]")
      ],
      grid(
        columns: (auto, 1fr),
        row-gutter: 0.75em,
        column-gutter: 2cm,
        [Bearbeitungszeitraum], handling-period,
        [Matrikelnummer, Kurs], [#author.matriculation-number, #author.major],
        [Ausbildungsfirma], [#company.name, #company.city],
        [Betreuer der Ausbildungsfirma], company.supervisor,
        [Gutachter der Dualen Hochschule], dhbw.reviewer,
      ),
    )
  }

  set text(size: 12pt)
  set par(
    leading: 0.75em,
    justify: true,
  )
  show par: set block(spacing: 1.2em)

  let signature = [
    #block(
      width: 50%,
      height: 2em,
      stroke: (
        bottom: 1pt,
      ),
      below: 8pt,
    )
    #signature.location, den #signature.date.display("[day].[month].[year]")
  ]

  // Affidavit
  [
    #heading(outlined: false)[Erklärung]
    gemäß Ziffer 1.1.13 der Anlage 1 zu §§ 3, 4 und 5 der Studien- und Prüfungsordnung für die Bachelorstudiengänge im Studienbereich Technik der Dualen Hochschule Baden-Württemberg vom 29.09.2017.

    Ich versichere hiermit, dass ich meine #article-kind mit dem Thema:

    #align(center, text(size: 14pt, lang: language, title))

    selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.
    Ich versichere zudem, dass die eingereichte elektronische Fassung mit der gedruckten Fassung übereinstimmt.

    #signature
  ]

  // Restriction Note
  if restriction-note [
    #heading(outlined: false)[Sperrvermerk]
    gemäß Ziffer 1.1.13 der Anlage 1 zu §§ 3, 4 und 5 der Studien- und Prüfungsordnung für die Bachelorstudiengänge im Studienbereich Technik der Dualen Hochschule Baden-Württemberg vom 29.09.2017.

    "Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb des Prüfungsprozesses und des Evaluationsverfahren zugänglich gemacht werden, sofern keine anders lautende Genehmigung vom Dualen Partner vorliegt."

    #signature
  ]


  set text(lang: language)

  pagebreak(weak: true)

  if abstract != none {
    heading(outlined: false, translations.abstract)
    abstract
  }

  if acronyms != none {
    heading(outlined: false, translations.acronyms)
    acronyms
  }

  pagebreak(weak: true)

  outline(indent: true)

  counter(page).update(0)
  set page(
    number-align: right,
    numbering: "1 / 1",
  )
  set heading(outlined: true, numbering: "1.1")

  set figure(placement: auto)

  body
}
