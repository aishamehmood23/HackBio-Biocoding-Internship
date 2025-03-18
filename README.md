# HackBio-Biocoding-Internship
## **About the Internship**  
The **HackBio BioCoding in R and Python** internship is a virtual program designed to equip participants with coding skills for biological data analysis. This program fosters a collaborative learning environment where interns work in teams, engage with mentors, and complete coding-based tasks that enhance their technical proficiency. The internship is organized into stages, with each stage focusing on a different coding exercise or real-world problem.

## **Stage-0 Task: Team Introduction**
The first task of this internship required us to create an organized representation of our team members' details using R or Python. This task emphasized the importance of structuring and managing data efficiently, a fundamental skill in coding for biological applications.

### **Task implementation:**
The code snippet for this task, included in this repository, defines a data frame in R that systematically stores and displays our team members’ details. This provides a structured approach to organizing data, setting the foundation for handling more complex datasets in future tasks.

For this task, R was used to structure and store the details of all team members in an organized and readable format.  

1. **Creating a Data Frame**:  
   The `data.frame()` function was used to create a data frame containing team members details. Each column represents a **specific attribute** and each **row corresponds to a team member**.  

2. **Defining Data Using `c()` Function**:  
   Inside the `data.frame()`, the c() function was used to list values for each column. This allowed to store multiple data points efficiently within the data frame.  

3. **Printing the Data Frame**:  
   Finally, the `print()` function was used to display the structured data in the console, making it easy to read.  

## **Stage-1 Task: Functions Galore!**
This stage required to write functions for DNA translation, simulating logistic population growth curve, and sequence comparison. Below is a detailed description of the tasks and functions implemented using R.

### **Task implementation:**
The code snippet for this task is included in Stage-1 folder

**Function for DNA to Protein Translation** 
This task required writing a function, translator(), that converts a given DNA sequence into a protein sequence using the standard genetic code and uses nchar() to check if
the sequence length is a multiple of three. Splits the DNA sequence into codons using substring(). Maps codons to their corresponding amino acids using a predefined codon
table and match(). Returns the translated protein sequence as a vector of amino acid abbreviations.

**Function for Logistic Population Growth Curve Simulation**
This task required writing a function, logistic_growth_curve(), to simulate and generate a logistic population growth curve. The function initializes a numeric vector using
numeric() to store population sizes at each time point. Iterates through time points using seq_along() and classifies growth into three phases: Lag phase: Population remains
constant (Pi), Log phase: Growth follows the logistic equation using exp(), Stationary phase: Population reaches the carrying capacity (K). Uses runif() to introduce
randomness in the lag and exponential phase durations. Stores results in a matrix (matrix()) and converts it into a dataframe (as.data.frame()). This function models
population dynamics and can be applied to various biological growth studies, including bacterial cell growth and environmental population changes.

**Generating a Dataframe with 100 Different Growth Curves**
This task required writing a script to generate a dataset containing 100 different logistic growth curves using the previously defined logistic_growth_curve() function. The
script initializes an empty dataframe (data.frame()) to store all growth curves. Defines key growth parameters (Pi, r, K) and introduces variability in the lag and
exponential phases using runif(). Uses a for loop to generate 100 growth curves, each with a unique curve_num identifier. Appends each generated curve to the dataframe using
rbind(). The final dataset provides a diverse set of population growth curves, useful for analyzing biological growth trends and variability.

**Time to reach 80% of the maximum growth**
This task involved writing a function to calculate the time required for a population to reach 80% of its carrying capacity using the logistic growth model. The function,
time_to_80(), accepts the initial population size, intrinsic growth rate, and carrying capacity as inputs, computes 80% of the carrying capacity, and then determines the
time based on a rearranged logistic growth equation. 

**Calculate hamming distance**
This task involved writing a function to compute the Hamming distance between two strings. The script defines a function hamming_distance() that calculates the Hamming
distance between two strings. Uses nchar() to determine string lengths, max() to get the longer string length when padding is needed, and unlist() (with strsplit) to compare
the strings character-by-character.

## **Stage-2 Task: Data Interpretation and Visualization**
### **RNA-Seq Differential Expression Analysis**
This task required analyzing an RNA-Seq dataset to identify differentially expressed genes between a diseased cell line and a diseased cell line treated with Compound X.
Below is a detailed description of the tasks and functions implemented using R.

### **Task implementation:**
The code snippet for this task is included in Stage-2 folder. A volcano plot was generated using base R plot() function, to visualize differentially expressed genes based on
Log2 Fold Change and statistical significance (-log10(p-value)). The dataset was filtered to extract genes that met the significance criteria. The top 5 most significant
upregulated and downregulated genes were determined based on p-values. The functions of the top differentially expressed genes were retrieved using GeneCards.

**Upregulated Genes Functions**
- EMILIN2: encodes a protein involved in extracellular matrix organization and cell adhesion. It plays a role in regulating cell proliferation and apoptosis.
- POU3F4: encodes a transcription factor critical for the development of the inner ear and certain neural structures. Mutations are associated with hearing impairments.
- LOC285954: an RNA Gene, and is affiliated with the lncRNA class. Diseases associated include Glioma Susceptibility 1 and Gastric Cancer.
- VEPH1: results in impaired TGF-beta signaling.
- DTHD1: encodes a protein containing a death domain, which is implicated in apoptotic signaling pathways and other cellular processes.

**Downregulated Genes Functions**
- TBX5: encodes a transcription factor essential for heart development and limb pattern formation. Mutations can lead to congenital disorders affecting the heart and limbs.
- LAMA2: encodes laminin subunit alpha-2, a component of the extracellular matrix. It mediates cell attachment, migration, and tissue organization during embryonic
  development. Mutations are linked to muscular dystrophy.
- CAV2: encodes caveolin-2, a protein involved in the formation of caveolae (small invaginations) on the cell membrane. It plays a role in signal transduction and may
  function as a tumor suppressor.
- IFITM1: encodes a protein that restricts cellular entry of various viral pathogens, including influenza A virus, Ebola virus, and SARS-CoV-2, thereby playing a role in
  innate immunity.
- TNN: encodes tenascin N, an extracellular matrix protein that, in tumors, stimulates angiogenesis by promoting endothelial cell elongation, migration, and sprouting.

**Results Interpretation**
The results suggest that Compound X influences cell signaling, apoptosis, extracellular matrix remodeling, and immune response. Upregulated genes indicate enhanced cell
remodeling and apoptosis, while downregulated genes suggest reduced immune signaling, adhesion, and tumor-related pathways. This may have implications for cancer treatment,
tissue repair, or immune modulation.

## **Stage-3 Task: Tumor Classification Using PCA and K-Means Clustering**
The objective of this task was to classify tumors as either benign or malignant using Principal Component Analysis (PCA) and K-Means clustering. Specifically,
the goals were:
- Dimensionality reduction using PCA to visualize patterns in the dataset.
- Applying K-Means clustering to classify and group the patients.
- Determining if there are potential subclasses within the dataset.

### **Task implementation:**
The code snippet for this task is included in Stage-3 folder. The cancer dataset was inspected for missing values, and necessary data type conversions were applied. To
ensure fair comparisons in PCA and clustering, the features were standardized using the scale() function. 

**Principal Component Analysis (PCA)**
PCA was applied to transform the high-dimensional dataset into a lower-dimensional space, capturing the most significant variance in the data. The first two principal
components explained a substantial portion of the variance, enabling effective visualization.

**PCA Interpretation**
The PCA plot illustrates the distribution of benign (blue circles) and malignant (yellow triangles) cases across two principal components. While the two groups exhibit some
separation, there is an observable overlap, indicating that some benign and malignant cases share similar characteristics in this reduced feature space. This suggests that
PCA alone is not sufficient for perfect classification, but it provides a solid foundation for further clustering methods.
![PCA Plot](PCA%20Plot.png)
