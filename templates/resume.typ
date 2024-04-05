  
#let default_font = "Source Sans Pro" 
#let accent_color = orange
#let light_grey = rgb("#7f7f7f")
#let dark_grey = rgb("#3f3f3f")
#let text_color = rgb("#131A28")
#let textsize = 8pt

#let resume(author: (), body) = {

  let date = datetime.today().display("[month repr:long] [day], [year]")

  let align_footer(left_body, center_body, right_body) = {
    block[
      #box(width: 1fr)[
        #align(left)[
          #left_body
        ]
      ]
      #box(width: 1fr)[
        #align(center)[
          #center_body
        ]
      ]
      #box(width: 1fr)[
        #align(right)[
          #right_body
        ]
      ]
    ]
  }

  show par: set block(above: 0.75em, below: 0.75em)

  set document(
    title: "Resume",
    author: author.first_name + " " + author.last_name,
    )

  set text(
    font: default_font,
    size: 12pt,
    lang: "en",
    fill: text_color,
    fallback: false,
  )
  
  set page(
    paper: "a4",
    margin: (top: 1cm, bottom: 1cm, left: 1.5cm, right: 1.5cm),
    flipped: false,
    footer: [
      #set text(fill: light_grey, size: 8pt)
      #align_footer[
        #smallcaps[#date]
      ][
        #smallcaps[
          #author.first_name
          #author.last_name
        ]
      ][
        #counter(page).display()
      ]
    ],
      footer-descent: 0pt,
  )

  set par(justify: true)

  set heading(
    numbering: none,
    outlined: false,
  )

  let name = {
    align(center)[
      #pad(bottom: 5pt)[
        #block[
          #set text(size: 32pt, style: "normal", fill: light_grey)
          #text(weight: "regular")[#author.first_name]
          #set text(fill: dark_grey)
          #text(weight: "bold")[#author.last_name]
        ]
      ]
    ]
  }

  let positions = {
    set text(
      size: 9pt,
      weight: "regular",
      fill: accent_color
    )
    align(center)[
      #smallcaps[
        #author.positions.join(
          text[#"  "#sym.dot.c#"  "]
        )
      ]
    ]
  }

  let contacts = {
    set box(height: 8pt)
    
    let linkedin_icon = box(image("../assets/icons/linkedin.svg"))
    let github_icon = box(image("../assets/icons/github.svg"))
    let email_icon = box(image("../assets/icons/email.svg"))
    let phone_icon = box(image("../assets/icons/phone.svg"))
    let homepage_icon = box(image("../assets/icons/homepage.svg"))
    let separator = box(width: 10pt)[#line(angle: 90deg, length: 8pt)]
    
    align(center)[
      #block[
        #set text(size: 8pt)
        #align(horizon)[
          #if author.phone != ""{
            phone_icon
            box[#link("tel:" + author.phone)[#text(" " + author.phone)]]
          }
          #if author.email != ""{
            separator
            email_icon
            box[#link("mailto:" + author.email)[#text(" " + author.email)]]
          }
          #if author.github != ""{
            separator
            github_icon
            box[#link("https://github.com/" + author.github)[#text(" " + author.github)]]
          }
          #if author.linkedin != ""{
            separator
            linkedin_icon
            box[
              #link(author.linkedin_link)[#text(" " + author.linkedin)]
            ]
          }
          #if author.website != ""{
            separator
            homepage_icon
            box[
              #link(author.website)[#text(" " + author.website)]
            ]
          }
        ]
      ]
    ] 
  }

  name
  positions
  contacts
  box(height: 20pt)
  body
}


// Content formatting

#let align_content(left_body, right_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

#let section_title(title) = {
  set text(
    size: 14pt,
    weight: "bold",
    fill: dark_grey,
    font: default_font,
  )
  align(left)[
    #text(fill: accent_color)[#title.slice(0, 1)]#text[#title.slice(1)]
    #box(width: 1fr)[#line(angle: 0deg, length: 100%)]
  ]
}

#let subsection_title(title) = {
  set text(
    size: 10pt,
    weight: "regular",
    fill: dark_grey,
    font: default_font,
  )
  align(left)[
    #text[#smallcaps[#title]]
  ]
}

#let detailed_entry(title: str, subtitle: str, date: str, location: str, body: list()) = {
  set text(
    size: textsize,
    weight: "regular",
    fill: dark_grey,
    font: default_font,
  )
  align_content[
    #text(fill: dark_grey, weight: "bold", size: 10pt)[#title]
    #linebreak()
    #box(height: 4pt)
    #text(weight: "regular")[#smallcaps[#subtitle]]
    #linebreak()
  ][
    #text(fill: accent_color, size: textsize, style: "italic")[#location]
    #linebreak()
    #box(height: 4pt)
    #text(fill: light_grey, size: textsize, style: "italic")[#date]
  ]
  
  set text(size: textsize, weight: "light")
  text[#body]
  box(height: 3pt)
}

#let short_entry(title: str, subtitle: str, date: str, location: str) = {
  set text(
    size: textsize,
    weight: "regular",
    fill: text_color,
    font: default_font,
  )
  align_content[
    #grid(columns: (40pt, 410pt), column-gutter: 8pt, align: (center, left),
      grid.cell[#text(fill: text_color, size: textsize)[#date]],
      grid.cell[#text(fill: dark_grey, weight: "bold", size: textsize)[#title] + #text(fill: text_color, size: textsize)[#subtitle]]
    )
  ][
    #text(fill: accent_color, size: textsize, style: "italic")[#location]
  ]
  box(height: 3pt)
}

#let minimal_entry(title: str, body: str) = {
  set text(
    size: textsize,
    weight: "regular",
    fill: text_color,
    font: default_font,
  )
  text(fill: dark_grey, weight: "bold")[#title]
  text(fill: text_color, size: textsize)[#body]
  box(height: 3pt)
}