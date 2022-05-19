const charactersList = document.getElementById('charactersList');
const charactersList2 = document.getElementById('charactersList2');
const searchBar = document.getElementById('searchBar');
let gpCharacters = [];

charactersList2.innerHTML = "Showing " + gpCharacters.length + " of " + gpCharacters.length + " results";

searchBar.addEventListener('keyup', (e) => {
    const searchString = e.target.value.toLowerCase();

    const filteredCharacters = gpCharacters.filter((myJsonData) => {

        if(searchString.length === 0) {
          //gpCharacters = []; 
           //console.trace("SPIDERMAN: " + gpCharacters.length);
          // charactersList.innerHTML = ${gpCharacters.length};
        }
        else return (
            myJsonData.name.toLowerCase().includes(searchString) ||
            myJsonData.card_num.toLowerCase().includes(searchString)||
            myJsonData.attributes[3].value.toLowerCase().includes(searchString)

        );

    });

    console.trace("_TEST: " + filteredCharacters.length);
    displayCharacters(filteredCharacters);
});

const loadCharacters = async () => {
    try {
        const res = await fetch('https://gomhaku.github.io/characters.json');
        gpCharacters = await res.json();
        //displayCharacters(gpCharacters);
       
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


    //console.trace("_TEST: " + characters.length + " of " + gpCharacters.length);
    //console.trace("SLICED: " + characters.slice(0,5));
        const htmlString = (characters.slice(0,10))
        //const htmlString2 = (characters.length)
    
        .map((myJsonData) => 
        {

        //if (characters.length < 50)
          //{
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
