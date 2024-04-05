  
#let default_font = "Source Sans Pro" 
#let accent_color = orange
#let light_grey = rgb("#7f7f7f")
#let dark_grey = rgb("#3f3f3f")
#let text_color = rgb("#131A28")
#let textsize = 9pt
#let date = datetime.today().display("[month repr:long] [day], [year]");


#let cover_letter(author: (), body) = {

  let align_footer(left_body, center_body) = {
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
        ]
      ]
    ]
  }

  show par: set block(above: 0.75em, below: 0.75em)

  set document(
    title: "cover_letter",
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
    margin: (top: 1cm, bottom: 1.5cm, left: 2cm, right: 2cm),
    flipped: false,
    footer: [
      #set text(fill: light_grey, size: 8pt)
      #align_footer[
        #text(smallcaps[#date])
      ][
        #text(smallcaps(author.first_name + " " + author.last_name))
      ]
    ]
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

#let align_address(left_body, rigth_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr, baseline: -1010%)[
      #align(right)[
        #rigth_body
      ]
    ]
  ]
}

#let address(company: str, street: str, city: str, zip: str, country: str, person: str) = {
  set text(
    size: 8pt,
    weight: "regular",
    fill: dark_grey
  )
  align_address[
      #text(size: 10pt, fill: dark_grey, weight: "bold", smallcaps(person))
      #linebreak()
      #linebreak()
      #text(smallcaps(company))
      #linebreak()
      #text(smallcaps(street))
      #linebreak()
      #text(smallcaps(city + ", " + zip))
      #linebreak()
      #text(smallcaps(country))
    ][
      #text(smallcaps(date), fill: light_grey, style: "italic")
    ]
}

#let opening(headline: str, name: str) = {
  set text(
    size: textsize,
    weight: "regular",
    fill: text_color
  )
  text(fill: dark_grey, weight: "bold")[#underline(headline)]
  linebreak()
  text("Dear " + name + ",")
  linebreak()
  linebreak()
}

#let content(body) = {
  set text(
    size: textsize,
    weight: "regular",
    fill: text_color
  )
  text(body)
  linebreak()
}

#let closing(name: str) = {
  set text(
    size: textsize,
    weight: "regular",
    fill: text_color
  )
  linebreak()
  text("Sincerely,")
  linebreak()
  linebreak()
  text(name, weight: "bold", fill: dark_grey)
}