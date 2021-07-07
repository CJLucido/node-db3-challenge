const db = require('../data/db-config')

module.exports = {
    find,
    findById,
    findSteps,
    add,
    addStep,
    update,
    remove


}

function find(){
    return db('schemes')
            .select('*')
}

function findById(id){
    return db('schemes')
            .select('*')
            .where({id})//returns ARRAY
            .first()//returns just the one!
}

function findSteps(id){

    return db('steps')
            .select('*')
            .join('schemes', 'schemes.id', 'steps.scheme_id')
            .where('schemes.id', id)
           
}

        function findStepsById(id, stepId){

            return db('steps')
                    .select('*')
                    .where({
                        scheme_id: id,
                        id: stepId
                    })
                    //.andWhere({id: stepId})
                .first()
        }


function add(schemeData){
    return db('schemes')
            .insert(schemeData, 'id') //we want it to return something, in this case the ids because we have a function we can use them in
            .then(ids =>{
                const id = ids[0]

               return findById(id)
            })
}


function addStep(stepData, id){ //stretch
    return db('steps')
            .insert(stepData, 'id')
            .then(ids => {
                const stepId = ids[0]
               return findStepsById(id, stepId)
            })
}


function update(changesToMake, schemeId){
     return db('schemes')
            .where({id: schemeId})
            .update(changesToMake)
            .then(count => {
                

                return findById(schemeId) 
                //`${count} records updated`
            })
            
}



function remove(schemeId){
    let removedScheme = findById(schemeId).then(item => item)// .then needed because the function returns a promise 

    return db('schemes')
    .where({id: schemeId})
    .del()
    .then((count) =>{
        if(count == 1){
            return removedScheme
    }else{
        return null
    }
    
    })
  
           
}



