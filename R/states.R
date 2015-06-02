#' State abbreviations, fips codes and state names
#'
#' @return a data frame with state abbreviations, fips codes, and state names
#' @examples 
#' states.df = getStatesFips()
#' 
getStatesFips = function() {
  
  abbr = c('AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 
           'GA', 'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 
           'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 
           'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 
           'UT', 'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY')
  
  fips = c('02', '01', '05', '60', '04', '06', '08', '09', '11', '10', '12', 
           '13', '66', '15', '19', '16', '17', '18', '20', '21', '22', '25', '24', 
           '23', '26', '27', '29', '28', '30', '37', '38', '31', '33', '34', '35', 
           '32', '36', '39', '40', '41', '42', '72', '44', '45', '46', '47', '48', 
           '49', '51', '78', '50', '53', '55', '54', '56')
  
  names = c('Alaska', 'Alabama', 'Arkansas', 'American Samoa', 'Arizona', 
            'California', 'Colorado', 'Connecticut', 'District Of Columbia', 'Delaware', 
            'Florida', 'Georgia', 'Guam', 'Hawaii', 'Iowa', 'Idaho', 'Illinois', 
            'Indiana', 'Kansas', 'Kentucky', 'Louisiana', 'Massachusetts', 'Maryland', 
            'Maine', 'Michigan', 'Minnesota', 'Missouri', 'Mississippi', 'Montana', 
            'North Carolina', 'North Dakota', 'Nebraska', 'New Hampshire', 'New Jersey', 
            'New Mexico', 'Nevada', 'New York', 'Ohio', 'Oklahoma', 'Oregon', 
            'Pennsylvania', 'Puerto Rico', 'Rhode Island', 'South Carolina', 
            'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Virginia', 'Virgin Islands', 
            'Vermont', 'Washington', 'Wisconsin', 'West Virginia', 'Wyoming')
  
  states = data.frame(abbr, fips, names)
  
  return(states)
  
}
