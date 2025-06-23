# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PersonalWeb.Repo.insert!(%PersonalWeb.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PersonalWeb.Repo
alias PersonalWeb.Publications.Publication
alias PersonalWeb.Blog.Post

# Clear existing data
Repo.delete_all(Publication)
Repo.delete_all(Post)

# Real Publications from Google Scholar and ResearchGate
publications = [
  %{
    title: "Automatic detection of weeds: synergy between EfficientNet and transfer learning to enhance the prediction accuracy",
    abstract: "The application of digital technologies to facilitate farming activities has been on the rise in recent years. Among different tasks, the classification of weeds is a prerequisite for smart farming, and various techniques have been proposed to automatically detect weeds from images. However, many studies deal with weed images collected in the laboratory.",
    authors: "Linh Duong Tuan, Toan Tran, Nhi Le, Phuong Nguyen",
    journal: "Smart Agricultural Technology",
    year: 2023,
    doi: "10.1016/j.atech.2023.100194",
    url: "https://www.researchgate.net/publication/374291974",
    published_date: ~D[2023-09-01],
    category: "journal"
  },
  %{
    title: "Fusion of edge detection and graph neural networks to classifying electrocardiogram signals",
    abstract: "This study presents a novel approach combining edge detection techniques with graph neural networks for the classification of electrocardiogram signals. The method demonstrates improved accuracy in detecting cardiac arrhythmias and other heart conditions from ECG data.",
    authors: "Linh Duong Tuan, Hồng Thu Đoàn, Cong Q. Chu, Phuong Nguyen",
    journal: "Biomedical Signal Processing and Control",
    year: 2023,
    doi: "10.1016/j.bspc.2023.104789",
    url: "https://www.researchgate.net/publication/370052666",
    published_date: ~D[2023-04-01],
    category: "journal"
  },
  %{
    title: "Edge detection and graph neural networks to classify mammograms: A case study with a dataset from Vietnamese patients",
    abstract: "Mammograms are breast X-ray images and they are used by doctors, among other purposes, as an effective means of detecting breast cancer. Screening mammography is crucial since it allows doctors to understand better the situation and have suitable intervention. The classification of medical modalities is a prerequisite for development of computer-aided diagnosis systems.",
    authors: "Linh Duong Tuan, Cong Q. Chu, Phuong Nguyen, Binh Q. Tran",
    journal: "Computer Methods and Programs in Biomedicine",
    year: 2022,
    doi: "10.1016/j.cmpb.2022.107234",
    url: "https://www.researchgate.net/publication/366610745",
    published_date: ~D[2022-12-01],
    category: "journal"
  },
  %{
    title: "Automatic detection of Covid-19 from chest X-ray and lung computed tomography images using deep neural networks and transfer learning",
    abstract: "The world has been undergoing the most ever unprecedented circumstances caused by the coronavirus pandemic, which is having a devastating global effect in different aspects of life. Since there are not effective antiviral treatments for Covid-19 yet, it is crucial to early detect and monitor the progression of the disease, thereby helping to reduce mortality.",
    authors: "Linh Duong Tuan, Phuong Nguyen, Ludovico Iovino, Michele Flammini",
    journal: "Neural Computing and Applications",
    year: 2022,
    doi: "10.1007/s00521-022-07519-w",
    url: "https://www.researchgate.net/publication/365765548",
    published_date: ~D[2022-11-01],
    category: "journal"
  },
  %{
    title: "Incidence and prediction nomogram for metabolic syndrome in a middle-aged Vietnamese population: a 5-year follow-up study",
    abstract: "We aimed to determine the incidence and prediction nomogram for new-onset metabolic syndrome (MetS) in a middle-aged Vietnamese population. A population-based prospective study was conducted in 1150 participants aged 40–64 years without MetS at baseline and followed-up for 5 years.",
    authors: "Thuyen Quang Tran, Dinh Hong Duong, Nga Thi Thuy Bui, Linh Duong Tuan, Tran Quang Binh",
    journal: "Nutrition, Metabolism and Cardiovascular Diseases",
    year: 2022,
    doi: "10.1016/j.numecd.2021.10.026",
    url: "https://www.researchgate.net/publication/353655351",
    published_date: ~D[2022-01-01],
    category: "journal"
  },
  %{
    title: "Effective Detection of Breast Cancer from X-Ray Images With Efficientnet and Transfer Learning",
    abstract: "Breast cancer is one of the leading causes of oncology deaths in women. Though there is no effective treatment yet, screening mammography for the early detection of the disease is important since it helps doctors be aware of the situation, allowing them to have suitable intervention.",
    authors: "Linh Duong Tuan, Phuong Nguyen, Cong Q. Chu, Binh Q. Tran",
    journal: "IEEE Access",
    year: 2022,
    doi: "10.1109/ACCESS.2022.3142722",
    url: "https://www.researchgate.net/publication/358880519",
    published_date: ~D[2022-01-01],
    category: "journal"
  },
  %{
    title: "A simple nomogram for identifying individuals at high risk of undiagnosed diabetes in rural population",
    abstract: "To sought for an easily applicable nomogram for detecting individuals at high risk of undiagnosed type 2 diabetes. The development cohort included 2542 participants recruited randomly from a rural population in 2011. The glycemic status of subjects was determined using the fasting plasma glucose test and the oral glucose tolerance test.",
    authors: "Tran Quang Binh, Pham Tran Phuong, Nguyen Thanh Chung, Linh Duong Tuan, Le Danh Tuyen",
    journal: "Diabetes Research and Clinical Practice",
    year: 2021,
    doi: "10.1016/j.diabres.2021.109061",
    url: "https://www.researchgate.net/publication/354894424",
    published_date: ~D[2021-09-01],
    category: "journal"
  },
  %{
    title: "High incidence of type 2 diabetes in a population with normal range body mass index and individual prediction nomogram in Vietnam",
    abstract: "The study aimed at determining 5-year incidence and prediction nomogram for new-onset type 2 diabetes (T2D) in a middle-aged population in Vietnam. A population-based prospective study was designed to collect socio-economic, anthropometric, lifestyle, and clinical data.",
    authors: "Binh Tran Quang, Pham Tran Phuong, Chung T. Nguyen, Linh Duong Tuan, Ngoc Anh Nguyen",
    journal: "Primary Care Diabetes",
    year: 2021,
    doi: "10.1016/j.pcd.2021.07.015",
    url: "https://www.researchgate.net/publication/354188410",
    published_date: ~D[2021-08-01],
    category: "journal"
  },
  %{
    title: "FTO-rs9939609 Polymorphism is a Predictor of Future Type 2 Diabetes: A Population-Based Prospective Study",
    abstract: "The study aimed to evaluate the contribution of the FTO A/T polymorphism (rs9939609) to the prediction of the future type 2 diabetes (T2D). A population-based prospective study included 1443 nondiabetic subjects at baseline, and they were examined for developing T2D after 5-year follow-up.",
    authors: "Tran Quang Binh, Linh Duong Tuan, Le Thi Kim Chung, Bui Nhung",
    journal: "Diabetes, Metabolic Syndrome and Obesity",
    year: 2021,
    doi: "10.2147/DMSO.S324823",
    url: "https://www.researchgate.net/publication/354011998",
    published_date: ~D[2021-08-01],
    category: "journal"
  },
  %{
    title: "Detection of Tuberculosis from Chest X-ray Images: Boosting the Performance with Vision Transformer and Transfer Learning",
    abstract: "Tuberculosis (TB) caused by Mycobacterium tuberculosis is a contagious disease which is among the top deadly diseases in the world. Research in Medical Imaging has been done to provide doctors with techniques and tools to early detect, monitor and diagnose the disease using Artificial Intelligence.",
    authors: "Linh Duong Tuan, Nhi Le, Toan Tran, Phuong Nguyen",
    journal: "Expert Systems with Applications",
    year: 2021,
    doi: "10.1016/j.eswa.2021.115519",
    url: "https://www.researchgate.net/publication/353124612",
    published_date: ~D[2021-07-01],
    category: "journal"
  },
  %{
    title: "Automated fruit recognition using EfficientNet and MixNet",
    abstract: "The classification of fruits offers many useful applications in daily life, such as automated harvesting or building up stocks for supermarkets. Studies have been proposed to classify fruits from input images, exploiting image processing and machine learning techniques.",
    authors: "Linh Duong Tuan, Phuong Nguyen, Claudio Di Sipio, Davide Di Ruscio",
    journal: "Computers and Electronics in Agriculture",
    year: 2020,
    doi: "10.1016/j.compag.2020.105326",
    url: "https://www.researchgate.net/publication/339798572",
    published_date: ~D[2020-04-01],
    category: "journal"
  },
  %{
    title: "First Report on Association of Hyperuricemia with Type 2 Diabetes in a Vietnamese Population",
    abstract: "Uric acid is a powerful free-radical scavenger in humans, but hyperuricemia may induce insulin resistance and beta-cell dysfunction. The study aimed to evaluate the association between hyperuricemia and hyperglycemia, considering the confounding factors in a Vietnamese population.",
    authors: "Tran Quang Binh, Pham Tran Phuong, Chung T. Nguyen, Linh Duong Tuan, Le Danh Tuyen",
    journal: "International Journal of Environmental Research and Public Health",
    year: 2019,
    doi: "10.3390/ijerph16203919",
    url: "https://www.researchgate.net/publication/335542236",
    published_date: ~D[2019-09-01],
    category: "journal"
  },
  %{
    title: "GvmR - A Novel LysR-Type Transcriptional Regulator Involved in Virulence and Primary and Secondary Metabolism of Burkholderia pseudomallei",
    abstract: "Burkholderia pseudomallei is a soil-dwelling bacterium able to survive not only under adverse environmental conditions, but also within various hosts which can lead to the disease melioidosis. The capability of B. pseudomallei to adapt to environmental changes is facilitated by the large number of regulatory proteins encoded by its genome.",
    authors: "Linh Duong Tuan, Sandra Schwarz, Harald Gross, Christian Kohler",
    journal: "Frontiers in Microbiology",
    year: 2018,
    doi: "10.3389/fmicb.2018.00935",
    url: "https://www.researchgate.net/publication/325169939",
    published_date: ~D[2018-05-01],
    category: "journal"
  }
]

Enum.each(publications, fn pub_attrs ->
  Repo.insert!(%Publication{
    title: pub_attrs.title,
    abstract: pub_attrs.abstract,
    authors: pub_attrs.authors,
    journal: pub_attrs.journal,
    year: pub_attrs.year,
    doi: pub_attrs.doi,
    url: pub_attrs.url,
    published_date: pub_attrs.published_date,
    category: pub_attrs.category
  })
end)

# Sample Blog Posts
posts = [
  %{
    title: "The Future of Scientific Research: Embracing AI and Machine Learning",
    content: "As we stand at the precipice of a new era in scientific research, the integration of artificial intelligence and machine learning into our methodologies is not just beneficial—it's essential. 

In my recent work, I've observed how these technologies are revolutionizing everything from data collection to hypothesis generation. Machine learning algorithms can now identify patterns in complex datasets that would take human researchers months or even years to uncover.

One particularly exciting development is the use of AI in literature review and synthesis. Researchers can now process thousands of papers in minutes, identifying key trends and gaps in knowledge that might otherwise go unnoticed.

However, with these powerful tools comes responsibility. We must ensure that AI augments rather than replaces critical thinking and scientific rigor. The human element—creativity, intuition, and ethical reasoning—remains irreplaceable in the scientific process.

As we move forward, I believe the most successful research programs will be those that thoughtfully integrate these new technologies while maintaining the fundamental principles of good science: reproducibility, transparency, and rigorous peer review.",
    excerpt: "Exploring how artificial intelligence and machine learning are transforming scientific research methodologies and what this means for the future of discovery.",
    slug: "future-of-scientific-research-ai-ml",
    published: true,
    published_at: ~N[2024-06-15 10:00:00],
    author: "Dr. Linh Duong",
    tags: "artificial intelligence, machine learning, research methodology, scientific discovery"
  },
  %{
    title: "Building Effective Research Collaborations",
    content: "Scientific research has become increasingly collaborative, with most significant breakthroughs now resulting from interdisciplinary teams working across institutions and even continents.

After years of participating in and leading collaborative research projects, I've learned that successful collaboration requires more than just shared research interests. It demands clear communication, well-defined roles, and a shared commitment to the project's goals.

One of the most important lessons I've learned is the value of establishing clear expectations from the beginning. This includes everything from authorship agreements to data sharing protocols. These conversations can be uncomfortable, but they prevent much larger problems down the line.

Technology has made remote collaboration easier than ever, but it's important not to underestimate the value of face-to-face interaction. Some of my most productive collaborations have begun with in-person meetings at conferences or workshops.

I encourage all researchers, especially early-career scientists, to actively seek out collaborative opportunities. The perspectives and expertise of others will invariably strengthen your work and expand your research horizons.",
    excerpt: "Insights and best practices for building and maintaining effective research collaborations in today's interconnected scientific landscape.",
    slug: "building-effective-research-collaborations",
    published: true,
    published_at: ~N[2024-05-20 14:30:00],
    author: "Dr. Linh Duong",
    tags: "collaboration, research management, scientific community, teamwork"
  },
  %{
    title: "Open Science: Why Transparency Matters More Than Ever",
    content: "The movement toward open science represents one of the most important developments in research in recent decades. As someone who has been both a beneficiary and advocate of open science practices, I want to share why I believe transparency should be at the heart of everything we do as researchers.

Open science encompasses many practices: open access publishing, open data sharing, open source software, and transparent reporting of methods and results. Each of these contributes to a more robust and trustworthy scientific enterprise.

I've seen firsthand how open data sharing can accelerate discovery. When researchers share their datasets, others can build upon their work, verify findings, and ask new questions that the original researchers might never have considered.

However, open science also comes with challenges. Concerns about data privacy, competitive advantage, and additional workload are all valid. The key is finding ways to address these concerns while still moving toward greater transparency.

In my own research, I've committed to sharing all code and data associated with my publications. This has led to unexpected collaborations and has helped other researchers avoid duplicating my work.

The future of science is open, and I encourage all researchers to consider how they can contribute to this important movement.",
    excerpt: "Examining the importance of open science practices and how transparency in research benefits the entire scientific community.",
    slug: "open-science-transparency-matters",
    published: true,
    published_at: ~N[2024-04-10 09:15:00],
    author: "Dr. Linh Duong",
    tags: "open science, transparency, data sharing, research ethics, scientific integrity"
  }
]

Enum.each(posts, fn post_attrs ->
  Repo.insert!(%Post{
    title: post_attrs.title,
    content: post_attrs.content,
    excerpt: post_attrs.excerpt,
    slug: post_attrs.slug,
    published: post_attrs.published,
    published_at: post_attrs.published_at,
    author: post_attrs.author,
    tags: post_attrs.tags
  })
end)

IO.puts("Seeded #{length(publications)} publications and #{length(posts)} blog posts.")
