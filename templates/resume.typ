
#let resume(author: (), body) = {

  let default_font = "Arial" 
  let accent_color = orange
  let light_grey = rgb("#7f7f7f")
  let dark_grey = rgb("#2a2a2a")
  let text_color = rgb("#131A28")

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
      #set text(fill: black, size: 8pt)
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
          #text(weight: "thin")[#author.first_name]
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
    let separator = box(width: 10pt)[#line(angle: 90deg, length: 8pt)]
    
    align(center)[
      #block[
        #set text(size: 8pt)
        #align(horizon)[
          #if author.phone != ""{
            phone_icon
            box[#text(" " + author.phone)]
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
        ]
      ]
    ] 
  }

  name
  positions
  contacts
  body
}


