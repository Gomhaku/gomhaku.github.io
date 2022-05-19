const charactersList = document.getElementById('charactersList');
const charactersList2 = document.getElementById('charactersList2');
const searchBar = document.getElementById('searchBar');
let gpCharacters = [];

charactersList2.innerHTML = "Showing " + gpCharacters.length + " of " + gpCharacters.length + " results";

searchBar.addEventListener('keyup', (e) => {
    const searchString = e.target.value.toLowerCase();

    const filteredCharacters = gpCharacters.filter((myJsonData) => {

        if(searchString.length === 0) {
          
        }
        else return (
            myJsonData.name.toLowerCase().includes(searchString) ||
            myJsonData.card_num.toLowerCase().includes(searchString)||
            myJsonData.attributes[3].value.toLowerCase().includes(searchString)
        );

    });

    displayCharacters(filteredCharacters);
});

const loadCharacters = async () => {
    try {
        const res = await fetch('https://gomhaku.github.io/characters.json');
        gpCharacters = await res.json();
       
    } catch (err) {
        console.error(err);
    }
};


const displayCharacters = (characters) => 
{

const displaySplit = (characters.slice(0,3))
{
    console.trace("DISPLAY SPLIT: " + displaySplit.length);
  
}

        const htmlString = (characters.slice(0,10))
    
        .map((myJsonData) => 
        {

        return `
            <li class="pet">
                <h2>${myJsonData.name}</h2>
                <p><br>Card Number: ${myJsonData.card_num}<br>
                Facial Expression: ${myJsonData.attributes[0].value}<br>
                Pet Type: ${myJsonData.attributes[1].value}<br>
                Pet Color: ${myJsonData.attributes[2].value}<br>
                Ribbon Pattern: ${myJsonData.attributes[3].value}<br>
                Ribbon Color: ${myJsonData.attributes[4].value}<br>
                Background Color: ${myJsonData.attributes[5].value}</p>
                <img src=${myJsonData.image}></img>
            </li>
        `;
        
        })
    
        .join('');
        
    charactersList.innerHTML = htmlString;

    if (characters.length > 10)
    {
charactersList2.innerHTML = "Showing first 10 of " + characters.length + " results";
    }
else
{
    charactersList2.innerHTML = "Showing " + characters.length + " of " + characters.length + " results";
}
    
};

loadCharacters();
