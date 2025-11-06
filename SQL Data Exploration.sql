use portfolioproject;
show tables;
select count(*) from portfolioproject.coviddeaths;
select count(*) from portfolioproject.covidvaccinations;
select * from portfolioproject.coviddeaths;
select * from portfolioproject.covidvaccinations;
show columns from coviddeaths;

update coviddeaths
set continent = null
where continent = '';

/*select data that we are going to be using*/

select Location, date, total_cases, new_cases, total_deaths, population
from portfolioproject.coviddeaths
where continent is not null 
order by 1,2;

/*Looking at Total Cases vs Total Deaths*/
/*Shows likelihood of dying if you contract covid in your country*/

select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
from portfolioproject.coviddeaths
where location like '%india%'
and continent is not null
order by 1,2;

/*Looking at Total Cases vs Population*/
/*Shows what percentage of population got covid*/

select Location, date, population, total_cases, (total_cases/population)*100 as PopulationInfected_Percentage
from portfolioproject.coviddeaths
/*where location like '%india%'*/
where continent is not null
order by 1,2;

/*Looking at Countries with Highest Infection Rate compared to Population*/

select Location, population, max(total_cases) as Highest_Infection_Count, max((total_cases/population))*100 as PopulationInfected_Percentage
from portfolioproject.coviddeaths
/*where location like '%india%'*/
where continent is not null
group by Location, population
order by PopulationInfected_Percentage desc;

/*Showing Countries with Highest Death Count per Population*/

select Location, max(total_deaths) as Total_Death_Count
from portfolioproject.coviddeaths
/*where location like '%india%'*/
where continent is not null
group by Location
order by Total_Death_Count desc;

/*Let's break things down by continent*/
/*Showing continents with the highest death count per population*/

select continent, max(total_deaths) as Total_Death_Count
from portfolioproject.coviddeaths
/*where location like '%india%'*/
where continent is not null
group by continent
order by Total_Death_Count desc;

/*GLOBAL NUBERS*/

select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases))*100 as Death_Percentage
from portfolioproject.coviddeaths
/*where location like '%india%'*/
where continent is not null
/*group by date*/
order by 1,2;

/*Looking at Total Population vs Vaccinations*/

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from portfolioproject.coviddeaths dea
join portfolioproject.covidvaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
where dea.continent is not null
order by 2, 3;


/*Use CTE*/

With PopvsVac (continent, location, date, population, new_vaccinations, Rolling_People_Vaccinated)
as (select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from portfolioproject.coviddeaths dea
join portfolioproject.covidvaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
where dea.continent is not null
/*order by 2, 3*/)
SELECT *, (Rolling_People_Vaccinated/population)*100
FROM PopvsVac;


/*TEMP Table*/
drop table if exists PercentPopulationVaccinated;
create temporary table PercentPopulationVaccinated
(
continent varchar(255),
location varchar(255),
date DATE,
population bigint,
new_vaccinations double,
Rolling_People_Vaccinated double
);


Insert into PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from portfolioproject.coviddeaths dea
join portfolioproject.covidvaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
/*where dea.continent is not null*/
/*order by 2, 3*/;

SELECT *, (Rolling_People_Vaccinated/population)*100
FROM PercentPopulationVaccinated;

/*Creating view to store data for later visualizations*/

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as Rolling_People_Vaccinated
from portfolioproject.coviddeaths dea
join portfolioproject.covidvaccinations vac
 on dea.location=vac.location
 and dea.date=vac.date
where dea.continent is not null
/*order by 2, 3*/;
